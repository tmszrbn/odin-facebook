require 'rails_helper'

RSpec.describe 'Friendship Request Menagement', type: :request do
  
  context 'when user is not signed in' do
    it 'redirects to sign in page if user is not logged in' do
      post friendship_requests_path
      expect(response).to redirect_to new_user_session_path
      delete friendship_request_path '1'
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when user is signed in' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    before do
      post user_session_path, params: { user: { email: user1.email, password: user1.password } }
    end
    context 'when users are friends already' do
      before do
        user1.friends << user2
      end
      it 'does not create new frienship request relationship' do
        post friendship_requests_path, params: { friendship_request: { sender_id: user1.id, receiver_id: user2.id } }
        expect(user1.sent_friendship_requests.count).to eq(0)
        expect(user2.received_friendship_requests.count).to eq(0)
      end
    end 
    context 'when users are not friends yet' do
      before do
        allow(user1).to receive(:friends_with?).with(user2).and_return(false)
      end
      context 'when users are not in the friendship request relationship yet' do
        before do
          allow(user1).to receive(:friendship_request_from?).with(user2).and_return(true)
          allow(user1).to receive(:friendship_request_to?).with(user2).and_return(true)
        end
        it 'does not create new frienship request relationship' do
          post friendship_requests_path, params: { friendship_request: { sender_id: user1.id, receiver_id: user2.id } }
        end
      end
      context 'when users are not in the friendship request relationship yet' do
        before do
          allow(user1).to receive(:friendship_request_from?).with(user2).and_return(false)
          allow(user1).to receive(:friendship_request_to?).with(user2).and_return(false)
        end
        context 'when are posted the right params' do
          before do
            post friendship_requests_path, params: { friendship_request: { sender_id: user1.id, receiver_id: user2.id } }
          end
          it 'creates new frienship request relationship' do
            expect(user1.sent_friendship_requests.count).to eq(1)
            expect(user2.received_friendship_requests.count).to eq(1)
          end
          it 'stays on the page' do
            # expect(response).to render_template
          end
        end
      end
    end 
  end
  
end