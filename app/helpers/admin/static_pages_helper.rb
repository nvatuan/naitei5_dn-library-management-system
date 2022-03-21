module Admin::StaticPagesHelper
  def dropdown_title
    is_admin? ? ".admin" : ".account"
  end
end
