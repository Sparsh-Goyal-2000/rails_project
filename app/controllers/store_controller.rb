class StoreController < ApplicationController
  skip_before_action :authorize, :set_last_activity, :set_logged_in_user, :set_counter
  
  def index
    @products = Product.order(:title)
  end
end
