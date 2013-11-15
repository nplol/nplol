class Dev::PostsController < ApplicationController
  http_basic_authenticate_with name: "rbear", password: "2pac", except: [:index, :show, :dev]

  def index
    @posts = Post.tagged_with('dev').order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    render 'posts/show'
  end

end
