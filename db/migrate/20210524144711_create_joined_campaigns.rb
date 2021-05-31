class CreateJoinedCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :joined_campaigns do |t|
      t.references :user, null: false, foreign_key: true
      t.float :user_donation_event, default: 0
      t.float :conversion_enterprise_donation, default: 0

      t.timestamps
    end
  end
end
