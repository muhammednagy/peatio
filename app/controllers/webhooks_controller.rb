class WebhooksController < ApplicationController
	before_action :auth_anybody!
	skip_before_filter :verify_authenticity_token
	def tx
		if params[:type] == "transaction" && params[:hash].present?
      transactions = exec "bitcoin-cli -rpcport=19332 listtransactions"
      puts transactions
      # txid = accounts.map{ |p| p[:txid] if p[:txid] == params[:hash] }.compact.join
      current_transaction = transactions.select{ |tr| tr[:txid] == params[:hash] }[0]
      puts current_transaction
      account = PaymentAddress.find_by_address(current_transaction[:address]).account
      current_balance = account.balance
      account.update(balance: current_balance + current_transaction[:amount])
      puts current_balance
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
