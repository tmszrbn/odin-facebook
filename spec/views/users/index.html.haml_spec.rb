require 'rails_helper'

RSpec.describe "users/index.html.haml", type: :view do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }

  describe 'displays list of all users' do
    before do
      allow(view).to receive(:current_user).and_return(user1)
      assign(:users, User.all)
    end
    context 'when displayed user is not current user\'s friend' do
      context 'when displayed user is not connected with current user by request friednship relationship' do
        it 'displays `request frienship` button next to the user' do
          render
          expect(rendered).to match /friendship_request_btn.*/
        end
      end
      context 'when displayed user is connected with current user by request friendship relationship' do
        it 'does not display `request friendship` button next to the user who' do
          allow(user1).to receive(:friendship_request_to?).and_return(true)
          allow(user1).to receive(:friendship_request_from?).and_return(false)
          render
          expect(rendered).not_to match /friendship_request_btn.*/
          allow(user1).to receive(:friendship_request_to?).and_return(false)
          allow(user1).to receive(:friendship_request_from?).and_return(true)
          render
          expect(rendered).not_to match /friendship_request_btn.*/
        end
      end
    end
    context 'when displayed user is current user\'s friend' do
      before do
        allow(user1).to receive(:friends_with?).with(user2).and_return(true)
        allow(user1).to receive(:friends_with?).with(user3).and_return(true)
      end
      it 'does not display `request friendship` button next to the user' do
        expect(rendered).not_to match /friendship_request_btn.*/
      end
    end
  end
end
