class Admin::StaticPagesController < Admin::AdminController
  before_action :check_admin_logged_in, only: :home

  def home; end
end
