module Admin
  class AuditLogsController < BaseController
    skip_load_and_authorize_resource

    def index
      @audits = Audit::AuditLog.order(:updated_at).reverse_order.page params[:page]
    end

  end
end
