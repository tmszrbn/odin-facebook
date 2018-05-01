require 'rails_helper'
require 'spec_helper'


RSpec.describe 'Posts Management' do
  
  context 'when user is not signed in' do
    it 'redirects to sign in page if user is not logged in' do
      get posts_path
      expect(response).to redirect_to new_user_session_path
      post posts_path
      expect(response).to redirect_to new_user_session_path
      get new_post_path
      expect(response).to redirect_to new_user_session_path
      get edit_post_path '1'
      expect(response).to redirect_to new_user_session_path
      get post_path '1'
      expect(response).to redirect_to new_user_session_path
      patch post_path '1'
      expect(response).to redirect_to new_user_session_path
      put post_path '1'
      expect(response).to redirect_to new_user_session_path
      delete post_path '1'
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'when user is signed in' do
    let(:user) { create(:user) }
    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
    end
    context 'when user is creating new post' do
      before do
        get new_post_path
      end
      it 'renders `new` template' do
        expect(response).to render_template (:new)
      end
    end
    context 'when user creates new post' do
      context 'when user uses `params[post]` with `title`, `content` and `user_id`' do
        before do
          post posts_path, params: { post: 
                                    { title: 'Post title', 
                                      content: 'Post content', 
                                      user_id: user.id } 
                                   }
        end
          it 'creates the new post' do
            expect(Post.last).to eq assigns(:post)
          end
          it 'redirects to the new post' do
            expect(response).to redirect_to assigns(:post)
          end
      end
      
    end

  end

end