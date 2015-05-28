class PostsController < ApplicationController
  before_filter :manage?, except: [:index, :show]
  before_filter :set_post, only: [:show, :edit, :update, :destroy]

  def index
    nplol? ? @posts = Post.all.order('created_at DESC').includes(:comments, :likes) : @posts = Post._public.order('created_at DESC').includes(:comments, :likes)
    score
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
    @post.set_siblings
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

  def score
    # 0 is the initial value
    candidates = @posts.select { |post| post.score > 0 }
    return unless candidates.any? # no popular posts, so why bother?
    avg_score = candidates.reduce(0) { |total, post| total + post.score } / candidates.length
    @posts.map { |post| post.popular = true if post.score > avg_score }
  end

  def post_params
    params.require(:post).permit(:title, :image, :tag_list)
  end

end
