require 'rails_helper'

RSpec.describe 'Likes Management' do
  
  context 'when user is not signed in' do
    it 'redirects to sign in page if user is not logged in' do
      post likes_path
      expect(response).to redirect_to new_user_session_path
      delete like_path '1'
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when user is signed in' do
    let(:user) { create(:user) }
    let(:posted) { create(:post) }
    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
    end
    it 'sets like from current user to the liked post' do
      allow(controller).to receive(:current_user).and_return(user)
      expect(posted.likers.count).to eq(0)
      expect(user.liked_posts.size).to eq(0)
      post likes_path, params: { like: { user_id: user.id, 
                                         likeable_id: posted.id, 
                                         likeable_type: 'Post' } }
      expect(posted.likers.count).to eq(1)
      expect(user.liked_posts.count).to eq(1)
    end
  end
  
end