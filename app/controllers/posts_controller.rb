class PostsController < ApplicationController
  before_action :require_login

  def index
    @like = Like.new
    @post = Post.new
    @posts = Post.all_by current_user.all_friends_ids << current_user.id
  end

  def edit
  end

  def update
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def destroy
  end

  def show
  end

  private 
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :photo)
    end
end
