class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      render @comment, layout: false
    else
      render json: { errors: @comment.errors.to_json }, status: 400
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text)
    end

end
