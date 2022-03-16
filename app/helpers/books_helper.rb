module BooksHelper
  def get_book_cover book
    # if book is nil, or book doesn't have :images
    # or book.images is empty, use default cover (in /asset) instead
    # else, use the first image in book's has_many images
    book&.try(:images)&.first || Settings.defaults.book_cover
  end
end
