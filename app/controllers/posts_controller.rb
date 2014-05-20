class PostsController < ApplicationController

  load_and_authorize_resource except: [:index, :show]

  rescue_from CanCan::AccessDenied do
    redirect_to root_path
  end


  def index
  	@posts = Post.all.order('created_at DESC')
    # xhr call made from global.js.coffee
    return render 'index', layout: false if request.xhr?
  end

  def new
  	@post = Post.new
  end

  def create
    meme? ? @post = Meme.new(meme_params) : @post = Post.new(post_params)
  	if @post.save
      redirect_to post_path(@post)
    else
    	render 'new'
    end
  end

  def form
    meme? ? @post = Meme.new : @post = Post.new
    render partial: 'posts/memes/meme_form', layout: false and return if meme?
    render partial: 'form', layout: false
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.meme? ? params = meme_params : params = post_params
    if @post.update(params)
      flash[:notice] = 'Post updated.'
      return redirect_to @post unless @post.meme?
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
  	@post = Post.find(params[:id])

    render 'show', layout: false if request.xhr?
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit( :title, :content, :tag_list, :type,
                                  asset_attributes: [  ] )
  end

  def meme_params
    params.require(:post).permit( :title, :type, :tag_list, :image)
  end

  def meme?
    params[:post_type] == 'meme'
  end

end
