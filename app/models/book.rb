class Book < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :publisher, optional: true
  has_many :written_by_authors, dependent: :destroy
  has_many :authors, through: :written_by_authors, dependent: :destroy
  has_many :borrow_requests, dependent: :nullify
  has_many :borrow_users, through: :borrow_requests, source: :users,
            dependent: :nullify
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :users,
            dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
end
