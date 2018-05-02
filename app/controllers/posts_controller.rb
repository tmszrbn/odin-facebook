class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.all
    @like = Like.new
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
      params.require(:post).permit(:title, :content, :user_id)
    end
end
