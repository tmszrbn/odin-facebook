class UsersController < ApplicationController
  before_action :require_login
  def index
  end

  def show
    @user = User.find(params[:id])
  end
end
