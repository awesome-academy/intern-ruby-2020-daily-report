class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_#{current_user.id}"
  end
end
