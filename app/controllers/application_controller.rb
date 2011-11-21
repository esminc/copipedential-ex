class ApplicationController < ActionController::Base
  include AuthenticateMethods

  protect_from_forgery
  before_filter :authenticate!, :personalize
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
    User.find_by_id(session[:user_id]).tap do |u|
      if u && (u.authorized_at.nil? || u.authorized_at < 1.days.ago)
        User.verify_org_member!(u)
      end
    end
  end

  # FIXME
  def personalize
    I18n.locale = 'ja'
    Time.zone = 'Asia/Tokyo'
  end
end

