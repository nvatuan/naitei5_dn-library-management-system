class BorrowRequest < ApplicationRecord
  UNACTIVE_STATUS = %w(rejected cancelled).freeze

  validates :borrowed_date, presence: true, allow_blank: false
  validates :return_date, presence: true, allow_blank: false
  validate :invalid_date_input?

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

  default_scope{joins :book, :user}

  scope :search_by, (lambda do |word|
    where "title LIKE :kw OR name LIKE :kw", kw: "%#{word}%" if word.present?
  end)

  scope :filter_by_status, ->(stts){where(status: stts) if stts.present?}

  scope :by_user, ->(user_id){where user_id: user_id}
  scope :by_book, ->(book_id){where book_id: book_id}

  scope :ordered_by_created_at, ->{order :created_at}
  scope :ordered_by_status, ->{order :status}
  scope :ordered_by_borrowed_date, ->{order :borrowed_date}
  scope :ordered_by_return_date, ->{order :return_date}

  scope :ordered_by, ->(sort_kw){send("ordered_by_#{sort_kw}")}
  scope :active_status, ->{where.not status: UNACTIVE_STATUS}

  private

  def invalid_date_input?
    return if [return_date.blank?, borrowed_date.blank?].any?

    return if  return_date > borrowed_date

    errors.add(:return_date, I18n.t("global.error.invalid_return_date"))
  end
end
