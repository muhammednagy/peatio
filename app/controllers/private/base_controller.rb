module Private
  class BaseController < ::ApplicationController
    before_action :check_email_nil
    before_filter :no_cache, :auth_member!
    before_action :secret_key_auth!
    before_action :two_factor_required!

    def secret_key_auth!
      unless current_user.identity.status_phone_number == true
        redirect_to key_secret_path
      end
    end

    def two_factor_required!
      if current_user.two_factors.where(type: "TwoFactor::App", activated: true).present?
        if two_factor_locked?(expired_at: ENV['SESSION_EXPIRE'].to_i.minutes)
          session[:return_to] = request.original_url
          redirect_to two_factors_path
        end
      else
        redirect_to verify_google_auth_path
      end
    end

    private

    def no_cache
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Sat, 03 Jan 2009 00:00:00 GMT"
    end

    def check_email_nil
      redirect_to new_authentications_email_path if current_user && current_user.email.nil?
    end

  end
end
