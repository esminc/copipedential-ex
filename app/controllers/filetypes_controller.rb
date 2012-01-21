class FiletypesController < ApplicationController
  def create
    Filetype.create!(params[:filetype])
    redirect_to :back
  end
end
