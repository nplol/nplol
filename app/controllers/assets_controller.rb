class AssetsController < ApplicationController

  before_filter: :authenticated?

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

  def destroy
    @asset = Asset.find(params[:id])

    @asset.destroy
    render nothing: true, status: :ok
  end

  private

  def asset_params
    params.require(:asset).permit(:image) if params[:asset]
  end

end
