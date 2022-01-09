class RemoveDeviseRecoverableFromChefs < ActiveRecord::Migration[5.1]
  def change
    remove_column(:chefs, :reset_password_token, :string)
    remove_column(:chefs, :reset_password_sent_at, :datetime)
  end
end
