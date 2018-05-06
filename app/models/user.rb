class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: %i[facebook]
  
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :liked_posts, through: :likes, source: :likeable, source_type: 'Post'

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :received_friendship_requests, class_name: "FriendshipRequest", foreign_key: 'receiver_id'
  has_many :sent_friendship_requests, class_name: "FriendshipRequest", foreign_key: 'sender_id'

  has_one  :image, as: :imageable


  def send_friendship_request receiver
    unless self.friendship_request_from?(receiver) || self.friendship_request_to?(receiver) || self.friends_with?(receiver) || self.equal?(receiver)
      self.sent_friendship_requests.create receiver_id: receiver.id
    end
  end
  def accept_friendship_request user
    if friendship_request_from?(user)
      self.friends << user 
      self.received_friendship_requests.where(sender_id: user.id).destroy_all
      user.sent_friendship_requests.where(receiver_id: self.id).destroy_all
    end
  end
  
  def friendship_request_to? user
    self.sent_friendship_requests.where(receiver_id: user.id).exists?
  end
  def friendship_request_from? user
    self.received_friendship_requests.where(sender_id: user.id).exists?
  end

  def all_friends
    self.friends + self.inverse_friends
  end
  def all_friends_ids
    self.all_friends.pluck(:id)
  end
  def friends_with? user
    self.friends.where(id: user.id).exists? || self.inverse_friends.where(id: user.id).exists?
  end

  def can_accept_friendship_request_from? user
    !self.friends_with?(user) && self.friendship_request_from?(user)
  end
  def can_send_friendship_request_to? user
    !self.friends_with?(user) && !self.friendship_request_from?(user) && !self.friendship_request_to?(user) && self != user
  end

  def create_post title, content
    self.posts.create title: title, content: content
  end

  def like_post post
    self.liked_posts << post unless self.likes_post? post
  end
  def likes_post? id
    self.liked_posts.where(id: id).exists?
  end

  def add_comment post, comment_body
    post.comments.create user_id: self.id, content: comment_body
  end

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    # user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
end
