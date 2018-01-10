class PartialTree < ActiveRecord::Base
  establish_connection DB_TRANSACTION
  
  belongs_to :account
  belongs_to :proof

  serialize :json, JSON
  validates_presence_of :proof_id, :account_id, :json

end
