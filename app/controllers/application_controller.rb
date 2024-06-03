class ApplicationController < ActionController::Base
  before_action :check_logged_in
  helper_method :current_user

  def check_logged_in
    return if current_user

    redirect_to root_path
  end

  private
  def current_user
    return unless (user_id = session[:user_id])

    @current_user ||= User.find_by(id: user_id)
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
