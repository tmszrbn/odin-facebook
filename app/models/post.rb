class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user
  has_many :images, as: :imageable
  has_attached_file :photo
  validates_attachment_content_type :photo, content_type: /\Aimage/
  
  def self.all_by users_ids
    Post.where(user_id: users_ids)
  end
end
