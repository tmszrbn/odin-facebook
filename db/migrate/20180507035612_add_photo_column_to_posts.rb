class AddPhotoColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_attachment :posts, :photo
  end
end
