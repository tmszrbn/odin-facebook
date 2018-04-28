class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

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

  def all_friends
    self.friends + self.inverse_friends
  end

  
  # private
    def friends_with? user
      self.friends.where(id: user.id).exists? || self.inverse_friends.where(id: user.id).exists?
    end
    
    def friendship_request_to? user
      self.sent_friendship_requests.where(receiver_id: user.id).exists?
    end
    def friendship_request_from? user
      self.received_friendship_requests.where(sender_id: user.id).exists?
    end
end