class AddPhoneNumberToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :phone_number, :string
    add_column :identities, :status_phone_number, :boolean
    add_column :identities, :otp_secret, :string
  end
end
