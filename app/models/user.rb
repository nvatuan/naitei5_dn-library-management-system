class User < ApplicationRecord
  has_many :follow_authors, dependent: :destroy
  has_many :authors, through: :follow_authors, dependent: :destroy
  has_many :borrow_requests, dependent: :nullify
  has_many :borrow_books, through: :borrow_requests, source: :books,
            dependent: :nullify
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_books, through: :bookmarks, source: :books,
            dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :images, as: :imageable, dependent: :destroy

  enum role: {user: 0, admin: 1}, _prefix: true
end
