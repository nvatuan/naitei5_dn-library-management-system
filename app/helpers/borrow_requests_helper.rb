module BorrowRequestsHelper
  def handle_data_date date, i18n_string = ".n_a"
    date.present? ? l(date, format: :long) : t(i18n_string)
  end
end
