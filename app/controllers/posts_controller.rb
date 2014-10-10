class PostsController < ApplicationController
  include GridHelper
  layout :layout?

  before_filter :nplol, only: [:index, :show]
  before_filter :manage?, except: [:index, :show]
  before_filter :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @nplol ? @posts = Post.all : @posts = Post._public
    set_grid
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
    return redirect_to root_path  unless @post.public? || @nplol 
    if params[:sibling]
      @post = Post.find(params[:id]).send(params[:sibling])
    else
      @post = Post.find(params[:id])
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def like
    return render json: { error: 'You need to log in to like shit, dude.' }, status: 401 unless current_user
    post = Post.find(params[:post_id])
    begin
      post.like(current_user)
    rescue
      return render json: { error: 'Already liked this post, clever fellow.'}, status: 401
    end
    render json: { likes: post.likes.count }, status: 200
  end

  private

  def layout?
    request.xhr? ? false : 'application'
  end
  
  def manage?
    authorize Post, :manage?
  end
 
  def nplol
    @nplol = current_user && current_user.nplol?
  end

  def set_post
    @post = Post.find(params[:id])
    throw 404 if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :image, :tag_list)
  end

end
