class PostsController < ApplicationController
  before_filter :set_post, only: [:edit, :update, :destroy]
  before_filter :nplol, only: [:index, :show]

  def index
    @nplol? @posts = Post.all : @posts = Post._public
    score(@posts) if @posts.length > 0
    @posts = @posts.to_a
    gridify(@posts)
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

  def score(posts)
    # 0 is the initial value
    avg_score = posts.reduce(0) { |total, post| total + post.score } / posts.length
    posts.map { |post| post.popular = true if post.score > avg_score }
  end

  # sort posts based on proper grid placement
  def gridify(posts)
    done = false
    until done do
      cand = nil
      posts.each_slice(2) do |post, nxt|
        return done = true if nxt.nil?
        if post.popular? && nxt.popular?
          cand = nxt
          break
        end
      end
      break if done
      swap_cand = posts.slice(posts.index(cand), posts.length).reject{ |post| post.popular? }.first
      break if swap_cand.nil?
      old_index, new_index = posts.index(cand), posts.index(swap_cand)
      posts[old_index], posts[new_index] = posts[new_index], posts[old_index]
    end
  end

end
