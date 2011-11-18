class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  def new
  end

  def create
    unless @user = User.find_by_auth_hash(auth_hash)
      @user = User.build_from_auth_hash(auth_hash)
      @user.save!
    end
    self.current_user = @user
    redirect_to :root
  rescue ActiveRecord::RecordInvalid => ex
    render(template:'sessions/forbidden', status: :forbidden)
  end

  def destroy
    self.current_user = nil
    reset_session
    redirect_to :sign_in
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
