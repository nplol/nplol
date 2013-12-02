class CommentsController < ApplicationController

  before_filter :setup_negative_captcha, only: :create
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(@captcha.values)
    
    if @captcha.valid? && @comment.save
      flash[:notice] = 'Comment created'
      if @post.tag_list.include? 'dev'
        redirect_to dev_post_path(@post)
      else
        redirect_to @post
      end
    else
      render 'posts/show'
    end
  end
 
  private
    def comment_params
      params.require(:comment).permit(:name, :text)
    end

end
