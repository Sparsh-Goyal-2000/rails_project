class AdminController < ApplicationController
  before_action :ensure_user_is_admin

  def index
    @orders = Order.by_date(5.day.ago)
  end

  def reports
    @from = params[:from]
    @to = params[:to]
    @orders = Order.by_date(@from, @to)

    render 'orders/index', orders: @orders
  end

  def catagories
    @catagories = Catagory.all

    render 'catagories/index', catagories: @catagories
  end
end
