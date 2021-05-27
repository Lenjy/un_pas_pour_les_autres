class CreateDonationPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :donation_payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :charity_event, null: false, foreign_key: true
      t.string :state
      t.monetize :amount, currency: { present: false }
      t.string :checkout_session

      t.timestamps
    end
  end
end
