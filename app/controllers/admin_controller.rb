class AdminController < ApplicationController
  before_action :ensure_user_is_admin

  def index
  end
end
