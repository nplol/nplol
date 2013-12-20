class AssetsController < ApplicationController

  http_basic_authenticate_with name: '2pac', password: '2pac'

  def new
    @asset = Asset.new
    render partial: 'form', layout: false
  end

  def create
    @asset = Asset.new(asset_params)

    if @asset.save
      render @asset, layout: false
    else
      render partial: 'form', layout: false, status: 400
    end
  end

  private

  def asset_params
    params.fetch(:asset, { }).permit(:image)
  end

end