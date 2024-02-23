class BookmarksController < ApplicationController
  def show
  end

  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(list_params)
    @bookmark.list = List.find(params[:list_id])
    @bookmark.save
    redirect_to list_path(params[:list_id])
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list_id)
  end

  private
  def list_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
