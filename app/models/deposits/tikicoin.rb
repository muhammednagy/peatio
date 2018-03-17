module Deposits
  class Tikicoin < ::Deposit
    include ::AasmAbsolutely
    include ::Deposits::Coinable
  end
end
