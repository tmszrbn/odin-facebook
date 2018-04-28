class RenameInFriendshipsFromFriend1AndFriend2ToUserAndFriend < ActiveRecord::Migration[5.2]
  def change
    rename_column :friendships, :friend1_id, :user_id
    rename_column :friendships, :friend2_id, :friend_id
  end
end
