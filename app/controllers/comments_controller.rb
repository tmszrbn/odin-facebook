class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new comment_params
    if @comment.save
    end
  end

  def destroy
  end
  
  def update
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :commentable_id, :commentable_type, :content)
    end

end
