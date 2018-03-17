class WebhooksController < ApplicationController
  before_action :auth_anybody!
  skip_before_filter :verify_authenticity_token

  def tx
    if params[:type] == "transaction" && params[:hash].present?
      AMQPQueue.enqueue(:deposit_coin, txid: params[:hash], channel_key: "satoshi")
      render :json => {:status => "queued"}
    end
  end

  def eth
    if params[:type] == "transaction" && params[:hash].present?
      AMQPQueue.enqueue(:deposit_coin, txid: params[:hash], channel_key: "ether")
      render :json => {:status => "queued"}
    end
  end

  def balance
    Rails.logger.info "Receive User Balance: #{params}"
    if params[:user]
      member = Member.find_by_email(params[:user])
      unless member
        render :json => {:status => "Cannot Find Account #{params[:user]}"}
        return
      end
      Rails.logger.info "Found User ID #{member}"
      currency = Currency.find_by_code(params[:currency])
      unless currency
        render :json => {:status => "Cannot Find Account #{params[:currency]}"}
        return
      end
      account = Account.find_by(member_id: member.id, currency: currency.id )
      unless currency
        render :json => {:status => "Cannot Find Account #{params[:currency]}"}
        return
      end
      Rails.logger.info "Found Account ID #{account}"
      account.plus_funds params[:amount].to_f, reason: Account::TIKI, ref: self
      render :json => {:status => "True"}
    end
      render :json => {:status => "Please pass user #{params[:user]}"}
  end

end
