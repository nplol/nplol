class PostsController < ApplicationController

  http_basic_authenticate_with name: "2pac", password: "2pac", except: [:index, :show, :dev]

  def index
  	@posts = Post.tagged_with('dev', exclude: true).order('created_at DESC')
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)

  	if @post.save
    	redirect_to @post
  	else
    	render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.update(params[:id], post_params)

    if @post.save
      flash[:notice] = 'Post updated.'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
  	@post = Post.find(params[:id])
    redirect_to dev_post_path(@post) if @post.tag_list.include? 'dev'
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :tag_list)
  end

end
