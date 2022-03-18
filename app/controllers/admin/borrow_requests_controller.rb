class Admin::BorrowRequestsController < Admin::AdminController
  before_action :check_admin_logged_in, only: %i(index show edit)

  def index
    @pagy, @borrow_reqs = pagy BorrowRequest.ordered_by_status
  end

  def show; end

  def edit; end
end
