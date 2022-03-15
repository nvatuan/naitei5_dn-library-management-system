class BooksController < ApplicationController
  def index
    @pagy, @books = pagy Book.published.ordered_by_date
  end

  def show
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t ".not_found"
    redirect_to books_path
  end
end
