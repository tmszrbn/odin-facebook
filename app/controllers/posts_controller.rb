class PostsController < ApplicationController
  def index
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def edit
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def new
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def create
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def destroy
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def show
    redirect_to new_user_registration_path unless user_signed_in?
  end
end
