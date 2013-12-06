class AssetsController < ApplicationController

  def new
    @asset = Asset.new
    render partial: 'form', layout: false
  end

  def create
    @asset.save
    render @asset.to_json
  end

end