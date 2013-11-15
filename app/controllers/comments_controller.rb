class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    
    if @comment.save
    	if @post.tag_list.include? 'dev'
        redirect_to dev_post_path(@post)
      else
        redirect_to @post
      end
      flash[:notice] = "Comment created"
    else
    	render :template => 'posts/show'
    end
  end
 
  private
    def comment_params
      params.require(:comment).permit(:name, :text)
    end
end
