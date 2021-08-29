class ApplicationController < ActionController::Base  
  before_action :set_logged_in_user, :authorize, :set_last_activity, :set_counter

  protected

  def set_logged_in_user
    @current_user = User.find(session[:user_id])
  end

  def authorize
    redirect_to login_url, notice: "Please log in" unless @current_user
  end

  def set_last_activity
    if Time.current - @current_user.updated_at > 300
      redirect_to logout_path, notice: 'Session Expired after 5 minutes of inactivity'
    else
      @current_user.update(updated_at: Time.current)
    end
  end

  def set_counter
    user_counter = @current_user.counters.find_by(url: request.original_url)
    if user_counter
      user_counter.increment(:count, by = 1)
    else
      @current_user.counters.create(url: request.original_url)
      user_counter = @current_user.counters.find_by(url: request.original_url)
    end
    @counter = user_counter.count
  end

  private

  def ensure_user_is_admin
    unless User.find(session[:user_id]).role == 'admin'
      redirect_to store_index_path, notice: 'You don\'t have privilege to access this section' 
    end
  end
end
