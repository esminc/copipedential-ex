class PostsController < ApplicationController
  respond_to :html
  def index
    @posts = Post.with_item.recent.page(params[:page]).per(per_page)
    respond_with(@posts)
  end
end
