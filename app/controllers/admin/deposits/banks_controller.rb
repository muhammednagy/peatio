module Admin
  module Deposits
    class BanksController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Bank'

      def index
        # start_at = DateTime.now.ago(60 * 60 * 24)
        if params[:date] == "3-month-ago"
          range_date = 3.month.ago.beginning_of_day..DateTime.now.end_of_day
        elsif params[:date] == "6-month-ago"
          range_date = 6.month.ago.beginning_of_day..DateTime.now.end_of_day
        elsif params[:date] == "all"
          range_date = @banks.pluck(:created_at)
        else
          range_date = 2.month.ago.beginning_of_day..DateTime.now.end_of_day
        end
        @oneday_banks = @banks.includes(:member).
          where(created_at: range_date).
          order('id DESC')

        @available_banks = @banks.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_banks -= @oneday_banks
      end

      def show
        flash.now[:notice] = t('.notice') if @bank.aasm_state.accepted?
      end

      def update
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        @bank.charge!(target_params[:txid])

        redirect_to :back
      end

      private
      def target_params
        params.require(:deposits_bank).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end
