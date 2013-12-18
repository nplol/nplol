class CommentsController < ApplicationController

  before_filter :setup_negative_captcha, only: :create
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(@captcha.values)
    
    if @captcha.valid? && @comment.save
      flash[:notice] = 'Comment created'
      render @comment, layout: false
    else
      render partial: 'form', layout: false
    end
  end
 
  private
    def comment_params
      params.require(:comment).permit(:name, :text)
    end

end
