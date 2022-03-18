class BorrowRequest < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, as: :commentable, dependent: :destroy

  delegate :name, to: :user, prefix: true
  delegate :title, to: :book, prefix: true

  enum status: {
    pending: 0,
    ready: 1,
    borrowed: 2,
    returned: 3,
    rejected: 4,
    cancelled: 5
  }, _prefix: true

  scope :by_user, ->(user_id){where(user_id: user_id)}
  scope :by_book, ->(book_id){where(book_id: book_id)}
  scope :ordered_by_status, ->{order :status}
  scope :ordered_by_borrowed_date, ->{order :borrowed_date}
  scope :ordered_by_return_date, ->{order :return_date}
end
