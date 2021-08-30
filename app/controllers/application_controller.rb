class ApplicationController < ActionController::Base  
  before_action :authorize, :set_last_activity, :set_counter
  around_action :set_responded_in_header

  protected

  def authorize
    @current_user = User.find(session[:user_id]) if session[:user_id]
    redirect_to login_url, notice: "Please log in" unless @current_user
  end

  def set_last_activity
    if (Time.current - 300).to_s > session[:last_activity]
      redirect_to logout_path, notice: 'Session Expired after 5 minutes of inactivity'
    else
      session[:last_activity] = Time.current
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

  def set_responded_in_header
    request_start_time = Time.current
    yield
    response.headers['x-responded-in'] = (Time.current - request_start_time) * 1000
  end

  private

  def ensure_user_is_admin
    unless User.find(session[:user_id]).role == 'admin'
      redirect_to store_index_path, notice: 'You don\'t have privilege to access this section' 
    end
  end
end
