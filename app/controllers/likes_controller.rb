class LikesController < ApplicationController 

  def create
    raise Exceptions::AuthenticationError unless logged_in?
    post = Post.find(params[:post_id])
    if current_user.like(post)
      render json: { likes: post.likes.count }, status: 200 
    else
      render json: { error: t('already_liked')}, status: 401
    end
  end

end
