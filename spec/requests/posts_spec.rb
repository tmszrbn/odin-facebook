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
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let(:user4) { create(:user) }
    let!(:post1) { create(:post, user: user1)}
    let!(:post2) { create(:post, user: user2)}
    let!(:post3) { create(:post, user: user3)}
    let!(:post4) { create(:post, user: user3)}
    let!(:post5) { create(:post, user: user4)}
    before do
      post user_session_path, params: { user: { email: user1.email, password: user1.password } }
    end
    context '#index' do
      before do
        get posts_path
      end
      it '@posts contains all posts of all users\'s friends' do
        allow(controller).to receive(:current_user).and_return(user1)
        expect(assigns(:posts).count).to eq(1)
        user1.friends << user2
        get posts_path
        expect(assigns(:posts).count).to eq(2)
        user1.inverse_friends << user3
        get posts_path
        expect(assigns(:posts).count).to eq(4)
      end
    end
    context '#new' do
      before do
        get new_post_path
      end
      it 'renders `new` template' do
        expect(response).to render_template (:new)
      end
    end
    context '#create' do
      context 'when user uses `params[post]` with `title`, `content` and `user_id`' do
        before do
          post posts_path, params: { post: 
                                    { title: 'Post title', 
                                      content: 'Post content', 
                                      user_id: user1.id } 
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