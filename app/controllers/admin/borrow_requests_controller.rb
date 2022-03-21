class Admin::BorrowRequestsController < Admin::AdminController
  before_action :check_admin_logged_in, only: %i(index show update)
  before_action :load_borrow_request, only: %i(show update)

  def index
    keyword, sort_kw = params.values_at :keyword, :sort_by

    # Check if sort keyword doesn't exists then use default instead
    sort_kw = "created_at" if sort_kw.blank?
    @borrow_reqs = BorrowRequest.ordered_by sort_kw

    # Collect "status"="1" into array of statuses
    # params = {
    #   "status_pending": "0", "status_ready": "1",
    #   "status_borrowed": "0", "status_return": "1",
    #   "status_rejected": "1", "status_cancelled: "0"
    # }
    # => statuses = ["ready", "return", "rejected"]
    statuses = []
    %w(pending ready borrowed returned rejected cancelled).each do |stt|
      status_name = "status_#{stt}"
      statuses << stt if params[status_name] == "1"
    end
    @borrow_reqs = @borrow_reqs.filter_by_status statuses

    # Seach for book title and author name
    @borrow_reqs = @borrow_reqs.search_by keyword

    @pagy, @borrow_reqs = pagy @borrow_reqs
  end

  def show; end

  def update
    status = params[:borrow_request][:status]
    unless BorrowRequest.statuses.keys.include? status
      flash.now[:danger] = t ".invalid_params"
      return render :show
    end

    if @borrow_req.update_attribute :status, status
      flash.now[:info] = t ".update_succeeded"
    else
      flash.now[:danger] = t ".update_failed"
    end
    render :show
  end

  private

  def load_borrow_request
    @borrow_req = BorrowRequest.find_by id: params[:id]
    return if @borrow_req

    flash[:danger] = t ".not_found"
    redirect_to admin_root_path
  end
end
