class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    byebug
    @comment.user = current_user

    if @comment.save
      render @comment, layout: false
    else
      render partial: 'form', layout: false, status: 400
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text)
    end

end
