class CommentsController < ApplicationController
  before_action :require_login
  def new
  end
  
  def edit
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def create
    redirect_to new_user_registration_path unless user_signed_in?
  end

end
