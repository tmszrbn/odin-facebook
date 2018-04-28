class CommentsController < ApplicationController
  def new
    redirect_to new_user_registration_path unless user_signed_in?
  end
  
  def edit
    redirect_to new_user_registration_path unless user_signed_in?
  end
end
