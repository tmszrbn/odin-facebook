class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :likeable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
