class AssetsController < ApplicationController

  def new
    @asset = Asset.new
    respond_to do |format|
      format.js
    end
  end

end