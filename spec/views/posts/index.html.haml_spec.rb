require 'rails_helper'

RSpec.describe "posts/index.html.haml", type: :view do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:post) { create(:post, user_id: user1.id) }
  let(:comment1) { create(:comment, user_id: user1.id, post_id: post.id)}
  let(:comment2) { create(:comment, user_id: user2.id, post_id: post.id)}

  before do
    assign(:posts, Post.all)
    # assigns(:likes) = Post.all
  end
  it 'displays post\'s content' do
    render
    expect(rendered).to render_template(partial: 'post')
  end
  it 'displays post\'s author'
  it 'displays post\'s comments'
  it 'displays post\'s likes'

end
