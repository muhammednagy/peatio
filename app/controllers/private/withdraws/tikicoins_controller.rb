module Private::Withdraws
  class TikicoinsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
