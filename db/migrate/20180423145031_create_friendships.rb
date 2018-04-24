class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :friend1
      t.references :friend2
      t.timestamps
    end
  end
end
