class Author < ApplicationRecord
  has_many :follow_authors, dependent: :destroy
  has_many :users, through: :follow_authors, dependent: :destroy
  has_many :written_by_authors, dependent: :destroy
  has_many :books, through: :written_by_authors, dependent: :destroy
end
