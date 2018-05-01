require 'rails_helper'

RSpec.describe "posts/new.html.haml", type: :view do
  include Devise::Test::ControllerHelpers

  let(:post) { Post.new }
  before do
    @post = post
      allow(controller).to receive(:current_user).and_return(build_stubbed(:user))
    render
  end
  it 'renders form with action `/posts` with method `post` ' do
    expect(rendered).to match(/^<form.*action="\/posts".*method="post"/)
  end
  it 'renders text input for title' do
    expect(rendered).to match(/<input.*type="text".*name="post\[title\]"/)
    
  end
  it 'renders textarea input for content' do
    expect(rendered).to match(/<textarea.*name="post\[content]"/)
  end
  it 'render hidden input for user_id' do
    expect(rendered).to match(/<input.*type="hidden".*name="post\[user_id]".*\/>/)
  end
  it 'renders submit input for creating post' do
    expect(rendered).to match(/^<input.*type="submit".*value="create post"/i)
  end

end
