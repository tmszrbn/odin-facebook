require 'rails_helper'

RSpec.describe "users/show.html.haml", type: :view do
  include Devise::Test::ControllerHelpers

  let(:user1) { create(:user) }
  let!(:post1) { create(:post, user: user1)}
  let!(:post2) { create(:post, user: user1)}
  let!(:post3) { create(:post, user: user1)}
  let!(:post4) { create(:post, user: user1)}
  
  before do
    allow(assigns(:user)).to receive(:email).and_return(user1.email)
    allow(assigns(:user)).to receive(:name).and_return(user1.name)
    allow(assigns(:user)).to receive(:posts).and_return(user1.posts)
    allow(controller).to receive(:current_user).and_return(user1)
    render
  end
  it 'displays contents of user\'s posts' do
    expect(rendered).to include(post1.content)
    expect(rendered).to include(post2.content)
    expect(rendered).to include(post3.content)
    expect(rendered).to include(post4.content)
  end
  it 'displays user\'s name' do
    expect(rendered).to include(user1.name)
  end
  it 'displays user\'s photo' do
    expect(rendered).to match /<img.*gravatar/
  end
end
