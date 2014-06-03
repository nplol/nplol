class PostsController < ApplicationController
  before_action :set_type, only: [:new, :create, :edit]

  def index
  	@posts = Post.all.order('created_at DESC')
    return render 'index', layout: false if request.xhr?
  end

  def new
    return redirect_to root_url unless params[:type]
    @post = type_class.new
    authorize @post, :manage?
  end

  def create
    @post = type_class.new(post_params)
    @post.author = current_user
    authorize @post, :manage?
    if @post.save
      redirect_to post_path(@post)
    else
    	render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post, :manage?
  end

  def update
    @post = Post.find(params[:id])
    authorize @post, :manage?
    if @post.update(post_params)
      flash[:notice] = 'Post updated.'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
    if params[:sibling]
      @post = Post.find(params[:id]).send(params[:sibling])
    else
      @post = Post.find(params[:id])
    end
    return render json: { error: 'Post not found'}, status: 400 if @post.nil?
    render 'show', layout: false if request.xhr?
  end

  def destroy
    @post = Post.find(params[:id])

    authorize @post, :manage?
    @post.destroy
    redirect_to root_path
  end

  private

  def set_type
    params[:post] ? @type = params[:post][:type] : @type = params[:type]
  end

  def type_class
    @type.constantize
  end

  def post_params
    # asset_attributes: [] required for nested attributes for assets.
    params.require(:post).permit(:title, :content, :tag_list, :image, :type, asset_attributes: [])
  end


end
