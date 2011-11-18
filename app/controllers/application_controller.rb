class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate!, :personalize
  responders :flash
  helper_method :signed_in?, :current_user, :organization

  private

  def authenticate!
    signed_in? or redirect_to sign_in_url
  end

  def organization
    User.organization
  end

  def signed_in?
    !!current_user
  end

  def current_user
    return nil if @current_user == :none
    return @current_user if @current_user

    self.current_user = User.find_by_id(session[:user_id])
    current_user
  end

  def current_user=(user)
    @current_user, session[:user_id] =
      user ? [user, user.id] : [:none, nil]
  end

  # FIXME
  def personalize
    I18n.locale = 'ja'
    Time.zone = 'Asia/Tokyo'
  end
end
