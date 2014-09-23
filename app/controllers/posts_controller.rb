class PostsController < ApplicationController
  include GridHelper

  before_filter :set_post, only: [:edit, :update, :destroy]
  before_filter :nplol, only: [:index, :show]
  after_filter :set_grid, only: :index

  def index
    @nplol? @posts = Post.all : @posts = Post._public
    return render 'index', layout: false if request.xhr?
  end

  def new
    @post = Post.new
    authorize @post, :manage?
  end

  def create
    @post = Post.new(post_params)
    authorize @post, :manage?
    @post.author = current_user
    if @post.save
      redirect_to @post
    else
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
    @post = Post.find(params[:id])
    redirect_to root_path unless @post.public? || @nplol
    if params[:sibling]
      @post = Post.find(params[:id]).send(params[:sibling])
    else
      @post = Post.find(params[:id])
    end
    return render json: { error: 'Post not found'}, status: 404 if @post.nil?
    render 'show', layout: false if request.xhr?
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def like
    post = Post.find(params[:post_id])
    begin
      post.like(current_user)
    rescue
      return render json: { error: 'Already liked this post, clever fellow.'}, status: 401
    end
    return render json: { }, status: 200
  end

  private

  def set_post
    @post = Post.find(params[:id])
    authorize @post, :manage?
  end

  def nplol
    @nplol = current_user && current_user.nplol?
  end

  def post_params
    params.require(:post).permit(:title, :image, :tag_list)
  end

end
