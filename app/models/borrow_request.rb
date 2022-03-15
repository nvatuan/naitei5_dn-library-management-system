class BorrowRequest < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, as: :commentable, dependent: :destroy

  enum status: {
    pending: 0,
    ready: 1,
    borrowed: 2,
    returned: 3,
    rejected: 4,
    cancelled: 5
  }, _prefix: true
end
