class RemoveCampaignFromEnterprises < ActiveRecord::Migration[6.0]
  def change
    remove_column :enterprises, :campaign_id
  end
end
