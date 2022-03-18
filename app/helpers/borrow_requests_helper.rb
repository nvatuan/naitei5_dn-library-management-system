module BorrowRequestsHelper
  def handle_data_date date
    date.present? ? l(date, format: :long) : t(".not_yet")
  end
end
