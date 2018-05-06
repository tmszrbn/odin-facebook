require 'rails_helper'

RSpec.describe 'shared/_navbar.html.haml' do
  let(:u1) { User.create email: 'user1@email.com', password: 'password', name: 'user1' }
  let(:u2) { User.create email: 'user2@email.com', password: 'password', name: 'user2' }
  let(:u3) { User.create email: 'user3@email.com', password: 'password', name: 'user3' }

  context 'when the user is not logged in' do
    before(:each) do
      allow(controller).to receive(:user_signed_in?).and_return(false)
    end
    it 'does not display friend requests' do
      render
      expect(rendered).not_to include('Friend requests')
    end
    it 'displays links to sign in' do
      render
      expect(rendered).to match /[Sign in | Sign in with Facebook].*[Sign in | Sign in with Facebook]/
    end
  end
  context 'when the user is logged in' do
    before(:each) do
      allow(controller).to receive(:user_signed_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(u1)
    end
    it 'displays log out link' do 
      render
      expect(rendered).to include('<a rel="nofollow" data-method="delete" href="/users/sign_out">')
    end
    context 'when the user has received friend requests' do
      it 'displays received friend requests' do
        u2.send_friendship_request u1
        u3.send_friendship_request u1
        render
        expect(rendered).to include(`<li>user1</li>\n<li>user2<li>`)
      end
      it 'displays the number of received friend requests' do
        allow(u1.received_friendship_requests).to receive(:count).and_return(1)
        render
        expect(rendered).to include("Friend requests: 1")
        allow(u1.received_friendship_requests).to receive(:count).and_return(0)
        render
        expect(rendered).to include("Friend requests: 0")
      end
    end
  end
end