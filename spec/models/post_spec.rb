require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '.posts_by' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let!(:post1) { create(:post, user: user1) }
    let!(:post2) { create(:post, user: user2) }
    let!(:post3) { create(:post, user: user2) }
    let!(:post4) { create(:post, user: user3) }
    it 'returns all posts created by users with ids in the array passed as an argument' do
      users_ids = []
      expect(Post.all_by(users_ids).count).to eq(0)
      users_ids << user1.id
      expect(Post.all_by(users_ids).count).to eq(1)
      users_ids << user2.id
      expect(Post.all_by(users_ids).count).to eq(3)
    end
  end
end
