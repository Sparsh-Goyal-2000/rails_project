class ApplicationController < ActionController::Base
  before_action :authorize

  protected

  def authorize
    unless User.find_by(id: session[:user_id]) && !User.count.zero?
        redirect_to login_url, notice: "Please log in"
    end
  end
  
  def set_logged_in_user
      @user = User.find(session[:user_id])
  end

end
