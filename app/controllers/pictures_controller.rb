class PicturesController < ApplicationController
  respond_to :html

  def show
    @picture = Picture.find(params[:id])
    respond_to do |f|
      f.html
      f.jpeg { send_data @picture.raw_data }
    end
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
