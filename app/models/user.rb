class User < ApplicationRecord
  EMAIL_REGEX = Settings.regex.email.freeze

  before_save :downcase_email

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

  validates :name, presence: true, length: {maximum: Settings.digits.digit_50}
  validates :email, presence: true,
            length: {maximum: Settings.digits.digit_255},
            format: {with: EMAIL_REGEX}, uniqueness: true
  validates :password, presence: true,
            length: {minimum: Settings.digits.digit_6}

  private

  has_secure_password

  def downcase_email
    email.downcase!
  end
end
