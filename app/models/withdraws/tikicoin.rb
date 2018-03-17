module Withdraws
  class Tikicoin < ::Withdraw
    include ::AasmAbsolutely
    include ::Withdraws::Coinable
  end
end
