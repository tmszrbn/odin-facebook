class CreateFriendshipRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendship_requests do |t|
      t.references :sender
      t.references :receiver
      t.timestamps
    end
  end
end
