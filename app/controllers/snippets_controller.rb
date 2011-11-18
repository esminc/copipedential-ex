class SnippetsController < ApplicationController
  respond_to :html
  # GET /snippets
  # GET /snippets.json
  def index
    @snippets = Snippet.order('updated_at DESC')
    respond_with(@snippets)
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    @snippet = Snippet.find(params[:id])
    respond_with @snippet
  end

  # GET /snippets/new
  # GET /snippets/new.json
  def new
    @snippet = current_user.snippets.build
    respond_with @snippet
  end

  # GET /snippets/1/edit
  def edit
    @snippet = current_user.snippets.find(params[:id])
  end

  # POST /snippets
  # POST /snippets.json
  def create
    @snippet = current_user.snippets.build(params[:snippet])
    @snippet.save
    respond_with(@snippet)
  end

  # PUT /snippets/1
  # PUT /snippets/1.json
  def update
    @snippet = current_user.snippets.find(params[:id])
    @snippet.update_attributes(params[:snippet])
    respond_with(@snippet)
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    @snippet = current_user.snippets.find(params[:id])
    @snippet.destroy

    respond_with(@snippet)
  end
end
