class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user
      t.string     :title
      t.text       :content
      t.references :image
      t.timestamps
    end
  end
end
