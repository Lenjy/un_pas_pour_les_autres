class CreateJoinedCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :joined_campaigns do |t|
      t.references :user, null: false, foreign_key: true
      t.float :user_donation_event
      t.float :conversion_enterprise_donation

      t.timestamps
    end
  end
end
