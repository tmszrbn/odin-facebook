class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user
  has_many :images, as: :imageable

  def self.all_by users_ids
    Post.where(user_id: users_ids)
  end
end
