module AuthenticateMethods
  extend ActiveSupport::Concern

  included do
    helper_method :signed_in?, :current_user
  end

  protected

  def authenticate!
    if signed_in?
      return true
    else
      redirect_to(sign_in_url) and return false
    end
  end

  def signed_in?
    !!current_user
  end

  def current_user
    return nil if @current_user == :none
    return @current_user if @current_user

    self.current_user = find_user
    current_user
  end

  def current_user=(user)
    @current_user, session[:user_id] =
      user ? [user, user.id] : [:none, nil]
  end
end

