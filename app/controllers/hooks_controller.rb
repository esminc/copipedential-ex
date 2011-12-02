class HooksController < ApplicationController
  respond_to :html
  # GET /hooks
  # GET /hooks.xml
  def index
    @hooks = Hook.all
    respond_with(@hooks)
  end

  # GET /hooks/1
  # GET /hooks/1.xml
  def show
    @hook = Hook.find(params[:id])
    respond_with(@hook)
  end

  # GET /hooks/new
  # GET /hooks/new.xml
  def new
    @hook = Hook.new
    respond_with(@hook)
  end

  # GET /hooks/1/edit
  def edit
    @hook = Hook.find(params[:id])
  end

  # POST /hooks
  # POST /hooks.xml
  def create
    @hook = Hook.new(params[:hook])
    @hook.save
    respond_with(@hook)
  end

  # PUT /hooks/1
  # PUT /hooks/1.xml
  def update
    @hook = Hook.find(params[:id])
    @hook.update_attributes(params[:hook])
    respond_with(@hook)
  end

  # DELETE /hooks/1
  # DELETE /hooks/1.xml
  def destroy
    @hook = Hook.find(params[:id])
    @hook.destroy
    respond_with(@hook)
  end
end
