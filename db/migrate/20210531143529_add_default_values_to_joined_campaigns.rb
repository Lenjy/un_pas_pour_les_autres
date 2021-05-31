class AddDefaultValuesToJoinedCampaigns < ActiveRecord::Migration[6.0]
  def change
    change_column :joined_campaigns, :user_donation_event, :float, default: 0
    change_column :joined_campaigns, :conversion_enterprise_donation, :float, default: 0
  end
end
