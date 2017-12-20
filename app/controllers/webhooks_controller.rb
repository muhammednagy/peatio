class WebhooksController < ApplicationController
	before_action :auth_anybody!
	skip_before_filter :verify_authenticity_token
	def tx
		if params[:type] == "transaction" && params[:hash].present?
      account = Account.find_by_member_id_and_currency(1, 2)
      current_balance = account.balance.to_i
      account.update(balance: current_balance + 0.001)
			AMQPQueue.enqueue(:deposit_coin, txid: params[:hash], channel_key: "satoshi")
			render :json => { :status => "queued" }
		end
	end
	def eth
		if params[:type] == "transaction" && params[:hash].present?
			AMQPQueue.enqueue(:deposit_coin, txid: params[:hash], channel_key: "ether")
			render :json => { :status => "queued" }
		end
	end
end
