require 'rails_helper'

RSpec.shared_examples 'does not create anymore friendship requests between these users' do |u1_sent, u2_sent|
  it 'does not create anymore friendship requests between these users' do
    u1.send_friendship_request u2 
    u2.send_friendship_request u1
    expect(u1.sent_friendship_requests.count).to eq(u1_sent)
    expect(u2.sent_friendship_requests.count).to eq(u2_sent)
  end
end

RSpec.describe User, type: :model do
  let(:u1) { User.create email: 'user1@email.com', password: 'password' }
  let(:u2) { User.create email: 'user2@email.com', password: 'password' }
  # let(:u3) { User.create email: 'user3@email.com', password: 'password' }
  describe '#send_friendship_request' do
    
    context 'when users are friends already' do
      before :each do
        u1.friends << u2
      end
      include_examples 'does not create anymore friendship requests between these users', 0, 0
    end
    
    context 'users are not friends yet' do
      context 'when one of the users sent friend request already' do
        before(:each) do
          u1.send_friendship_request u2
        end
        include_examples 'does not create anymore friendship requests between these users', 1, 0
      end
      context 'when none of the users sent friend request yet' do
        it 'sets friend request relationship between users' do
          u1.send_friendship_request u2
          expect(u2.received_friendship_requests.to_a.last.sender_id).to eq(u1.id)
        end
      end
    end

    it 'does not set friend request relationship of user with itself' do
      u1.send_friendship_request u1
      expect(u1.sent_friendship_requests.count).to eq(0)
      expect(u1.received_friendship_requests.count).to eq(0)
    end
  end

  describe '#accept_friendship_request' do
    context 'there is no sent friendship request between users' do
      it 'does nothing' do
        u1.accept_friendship_request u2
        expect(u1.friends.count).to eq(0)
      end
    end    
    context 'there is sent friendship request between users' do
      before(:each) do
        u1.send_friendship_request u2
        u2.accept_friendship_request u1
      end
      it 'creates friends relation' do
        expect(u1.all_friends.count).to eq(1)
      end
      it 'deletes friendship request relation' do
        expect(u1.sent_friendship_requests.count).to eq(0)
      end
    end    
  end
end
