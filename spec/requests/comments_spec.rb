require 'rails_helper'

RSpec.describe 'Comments Management' do


  let(:user) { create(:user) }
  let(:posted) { create(:post) }
  
  context 'when user is not signed in' do
    it 'redirects to sign in page' do
      post comments_path, params: { comment: 
                                    { commentable_id: posted.id, 
                                      commentable_type: posted.class,
                                      user_id: user.id,
                                      content: 'Content of the comment' } }
      expect(response).to redirect_to new_user_session_path
      delete comment_path '1'
      expect(response).to redirect_to new_user_session_path
      patch comment_path '1'
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when user is signed in' do
    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      post comments_path, params: { comment: 
                                    { commentable_id: posted.id, 
                                      commentable_type: posted.class,
                                      user_id: user.id,
                                      content: 'Content of the comment' } }
    end
    it 'creates new comment' do
      expect(user.comments.count).to eq(1)
      expect(posted.comments.count).to eq(1)
      expect(Comment.count).to eq(1)
    end
  end
  
end