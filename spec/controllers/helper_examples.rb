RSpec.shared_examples 'redirecting_not_logged_in' do |action, method|

  it 'when the user is not logged in redirects to sign in page' do
    allow(controller).to receive(:user_signed_in?).and_return(false)
    unless method
      get action
    else
      if method == :post
        post action
      elsif method == :delete
        delete action
      end
    end
    expect(response).to redirect_to(new_user_session_url)
  end
  it "when the user is logged in returns http success" do
    allow(controller).to receive(:user_signed_in?).and_return(true)
    unless method
      get action
    else
      if method == :post
        post action
      elsif method == :delete
        delete action
      end
    end
    expect(response).to be_successful
  end
end