class CommentsController < ApplicationController
  before_action :require_login, except: [:new]

  def new
  end
  
  def edit
    redirect_to new_user_session_path unless user_signed_in?
  end

  def create
    redirect_to new_user_session_path unless user_signed_in?
  end

end
