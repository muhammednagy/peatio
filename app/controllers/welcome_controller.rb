class WelcomeController < ApplicationController
  before_filter :auth_member!, only: :key_secret
  layout 'landing'

  def index
  end

  def key_secret
    if params[:key_secret].present?
      if params[:key_secret][:otp] == current_user.identity.otp_secret
        current_user.identity.update_attribute('status_phone_number', true)
        redirect_to settings_path, notice: "Member active!"
      else
        flash[:alert] = "Verification code is incorrect"
      end
    end
    unless current_user.identity.otp_secret.present?
      totp = ROTP::TOTP.new("base32secret3232")
      current_user.identity.update_attribute('otp_secret', totp.now)
      phone_number = Phonelib.parse(current_user.identity.phone_number).international
      client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
      client.messages.create(
        from: ENV["TWILIO_NUMBER"],
        to:   phone_number,
        body: "Your verification code is #{totp.now}"
      )
    end
  end

  def resend_otp_code
    totp = ROTP::TOTP.new("base32secret3232")
    current_user.identity.update_attribute('otp_secret', totp.now)
    phone_number = Phonelib.parse(current_user.identity.phone_number).international
    client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
    client.messages.create(
      from: ENV["TWILIO_NUMBER"],
      to:   phone_number,
      body: "Your verification code is #{totp.now}"
    )
    redirect_to key_secret_path, notice: "Your verification code has been sent to #{phone_number}",
                                 alert: nil
  end
end
