module Admin
  module Deposits
    class SatoshisController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Satoshi'

      def index
        # start_at = DateTime.now.ago(60 * 60 * 24 * 365)
        if params[:date] == "3-month-ago"
          range_date = 3.month.ago.beginning_of_day..DateTime.now.end_of_day
        elsif params[:date] == "6-month-ago"
          range_date = 6.month.ago.beginning_of_day..DateTime.now.end_of_day
        elsif params[:date] == "all"
          range_date = @satoshis.pluck(:created_at)
        else
          range_date = 2.month.ago.beginning_of_day..DateTime.now.end_of_day
        end
        @satoshis = @satoshis.includes(:member).
          where(created_at: range_date).
          order('id DESC').page(params[:page]).per(20)
      end

      def update
        @satoshi.accept! if @satoshi.may_accept?
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
