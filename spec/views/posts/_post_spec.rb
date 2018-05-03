require 'rails_helper'

RSpec.describe 'posts/_post.html.haml' do

  include Devise::Test::ControllerHelpers

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:post) { create(:post, user_id: user1.id) }
  let!(:comment1) { create(:comment, user_id: user1.id, commentable_id: post.id)}
  let!(:comment2) { create(:comment, user_id: user2.id, commentable_id: post.id)}
  
  before do
    allow(controller).to receive(:current_user).and_return(user1)
    render partial: 'posts/post.html.haml', locals: { post: post }
  end
  it 'displays post\'s content' do
    expect(rendered).to include(post.content)
  end
  it 'displays post\'s author' do
    expect(rendered).to include(post.user.name)
  end
  it 'displays post\'s likes count' do
    expect(rendered).to include("#{post.likes.count}")
  end
  it 'displays post\'s comments' do
    expect(rendered).to include(comment1.content)
    expect(rendered).to include(comment2.content)
  end
end