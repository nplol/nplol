class CommentsController < ApplicationController

  http_basic_authenticate_with name: "sevve", password: "lovaas"

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    
    if @comment.save
    	redirect_to post_path(@post)
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
