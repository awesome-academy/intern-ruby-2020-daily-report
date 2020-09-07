class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build comment_params
    @error = true unless @comment.save
    respond_to :js
  end

  private

  def comment_params
    params.permit Comment::COMMENT_PARAMS
  end
end
