module Admin
  class ReportsController < AdminController
    def index
      @from = params[:from]
      @to = params[:to]
      if @from.blank? and @to.blank?
        @orders = Order.by_date(5.day.ago)
      else
        @orders = Order.by_date(@from, @to)
      end
    end
  end
end
