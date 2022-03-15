class WrittenByAuthor < ApplicationRecord
  belongs_to :author
  belongs_to :book
end
