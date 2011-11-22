class ApplicationController < ActionController::Base
  include AuthenticateMethods

  protect_from_forgery
  before_filter :authenticate!, :authorize!, :personalize
  responders :flash
  helper_method :organization

  private

  def organization
    User.organization
  end

  def per_page
    Integer(params[:per_page]) rescue 20
  end

  def find_user
    User.find_by_id(session[:user_id])
  end

  def authorize!
    if signed_in? && (current_user.authorized_at.nil? || current_user.authorized_at < 1.days.ago)
      User.verify_org_member!(current_user)
    end
  end

  # FIXME
  def personalize
    I18n.locale = 'ja'
    Time.zone = 'Asia/Tokyo'
  end
end

