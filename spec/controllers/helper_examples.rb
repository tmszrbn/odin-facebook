RSpec.shared_examples 'redirecting_not_logged_in' do |action|
  it 'when the user is not logged in redirects to sign in page' do
    allow(controller).to receive(:user_signed_in?).and_return(false)
    get action
    expect(response).to redirect_to(new_user_registration_url)
  end
  it "when the user is logged in returns http success" do
    allow(controller).to receive(:user_signed_in?).and_return(true)
    get action
    expect(response).to have_http_status(:success)
  end
end