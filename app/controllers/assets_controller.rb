class AssetsController < ApplicationController

  def new
    @asset = Asset.new
    render partial: 'form', layout: false
  end

  def create
    @asset = Asset.new(asset_params)

    if @asset.save
      render json: @asset.to_json(methods: [:thumb_url, :large_url])
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
