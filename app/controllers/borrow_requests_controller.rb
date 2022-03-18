class BorrowRequestsController < ApplicationController
  before_action :check_logged_in?, only: %i(index show)

  def index
    @pagy, @borrow_reqs = pagy BorrowRequest.by_user(current_user.id)
                                            .ordered_by_status
  end

  def show
    @borrow_req = @current_user.borrow_requests.find_by id: params[:id]
    return if @borrow_req

    store_location
    flash[:danger] = t "global.error.no_permission"
    redirect_to home_path
  end

  private

  def check_logged_in?
    return if logged_in?

    store_location
    flash[:danger] = t "global.error.need_log_in"
    redirect_to login_url
  end
end
