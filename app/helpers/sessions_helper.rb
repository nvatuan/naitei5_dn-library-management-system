module SessionsHelper
  def login user
    session[:user_id] = user.id
  end

  def remember_user user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = {
      value: user.remember_token,
      httponly: true
    }
  end

  def current_user
    user_id ||= session[:user_id] || cookies.signed[:user_id]
    remember_token = cookies[:remember_token]

    @current_user ||= User.find_by id: user_id
    login @current_user if @current_user&.authenticate_token? remember_token

    @current_user
  end

  def logged_in?
    current_user.present?
  end

  def is_admin?
    current_user.role_admin?
  end

  def forget user
    user&.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def redirect_back_or default
    redirect_to(session[:forward_url] || default)
    session.delete :forward_url
  end

  def store_location
    session[:forward_url] = request.original_url if request.get?
  end
end
