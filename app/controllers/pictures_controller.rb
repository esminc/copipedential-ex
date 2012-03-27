class PicturesController < ApplicationController
  respond_to :html

  def show
    @picture = Picture.find(params[:id])
  end

  def raw
    show unless @picture
    send_data @picture.raw_data
  end

  def edit
    @picture = current_user.pictures.find(params[:id])
  end

  def create
    @picture = current_user.pictures.build
    @picture.raw_data = params[:raw_data]
    @picture.save || @picture.clean_data
    respond_with(@picture)
  end

  def update
    @picture = current_user.pictures.find(params[:id])
    @picture.update_attributes!(params[:picture])

    respond_with(@picture)
  end

end
