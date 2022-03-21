class Admin::AdminController < ApplicationController
  layout "admin"

  private

  def check_admin_logged_in
    unless logged_in?
      store_location
      flash[:danger] = t "global.error.need_log_in"
      redirect_to login_url
      return
    end

    return if is_admin?

    flash[:danger] = t "global.error.unauthorized"
    redirect_to root_url
  end
end
