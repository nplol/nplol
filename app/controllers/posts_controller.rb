class PostsController < ApplicationController
  before_filter :manage?, except: [:index, :show]
  before_filter :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.list(nplol?)
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to @post
    else
      flash[:error] = @post.errors.messages
      render 'new'
    end
  end

  def edit
    redirect_to root_path unless @post.author == current_user
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated.'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
    return user_not_authorized  unless @post.public? || nplol? 
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private
 
  def manage?
    authorize Post, :manage?
  end
 
  def set_post
    @post = Post.find(params[:id])
    throw 404 if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :image, :tag_list)
  end

end
