class AssetsController < ApplicationController

  def new
    @asset = Post.find(params[:post_id]).assets.build
    respond_to do |format|
      format.js
    end
  end

end