class AssetsController < ApplicationController

  def new
    @asset = Post.find(params[:post_id]).assets.build

    render layout: false
  end
end