class ApplicationController < ActionController::Base
  before_action :require_login
  private
    def require_login
      redirect_to new_user_session_path unless user_signed_in?
    end  

end
