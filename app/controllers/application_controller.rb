class ApplicationController < ActionController::Base  
    before_action :set_logged_in_user
    before_action :authorize
    before_action :check_last_activity
    before_action :set_counter

    protected

    def authorize
        @current_user = User.find_by(id: session[:user_id])
        unless @current_user
            redirect_to login_url, notice: "Please log in"
        end
    end

    def set_logged_in_user
      @current_user = User.find_by(id: session[:user_id])
      if @current_user.nil?
        redirect_to login_url 
      else
        @current_user.set_last_activity
      end
    end

    def check_last_activity
      @current_user = User.find_by(id: session[:user_id])
      if @current_user.nil?
        redirect_to login_url 
      elsif Time.current - @current_user.updated_at > 300
        redirect_to logout_path, notice: 'Session Expired after 5 minutes of inactivity'
      else
        @current_user.set_last_activity
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
