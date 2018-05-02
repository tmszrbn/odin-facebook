require 'rails_helper'

describe 'Friendship Management' do
  
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
 
  context 'when user is not signed in' do
    it 'redirects to sign in page if user is not logged in' do
      post friendships_path, params: { friendship: { user_id: user1.id, friend_id: user2.id } }
      expect(response).to redirect_to new_user_session_path
      delete friendship_request_path '1'
      expect(response).to redirect_to new_user_session_path
    end
  end
  
  context 'when user is signed in and tries to create a friendship' do
    before do
      post user_session_path, params: { user: { email: user1.email, password: user1.password } }
    end
    context 'when users are friends already' do
      before do
        allow(user1).to receive(:friends_with?).with(user2).and_return(true)
      end
      it 'does not create new frienship' do
        post friendships_path, params: { friendship: { user_id: user1.id, friend_id: user2.id } }
        expect(user1.friends.count).to eq(0)
      end
    end
    context 'when users are not friends yet' do
      before do
        allow(user1).to receive(:friends_with?).with(user2).and_return(false)
      end
      context 'when the current user is not the receiver of the friendship request' do
        before do
          allow(user1).to receive(:friendship_request_from?).with(user2).and_return(false)
        end
        it 'does not create new friendship'  do
          post friendships_path, params: { friendship: { user_id: user1.id, friend_id: user2.id } }
          expect(user1.friends.count).to eq(0)
        end
      end
      context 'when the current user is the receiver of the friendship request' do
        before do
          user2.send_friendship_request user1
        end
        it 'does create new friendship' do
          post friendships_path, params: { friendship: { user_id: user1.id, friend_id: user2.id } }
          expect(user1.friends.count).to eq(1)
        end
      end
    end
  end
end