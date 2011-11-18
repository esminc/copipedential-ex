class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :personalize

  private

  # FIXME
  def personalize
    I18n.locale = 'ja'
    Time.zone = 'Asia/Tokyo'
  end
end
