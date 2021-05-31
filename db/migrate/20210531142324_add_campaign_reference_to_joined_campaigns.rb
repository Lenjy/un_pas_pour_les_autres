class AddCampaignReferenceToJoinedCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_reference :joined_campaigns, :campaign, null: false, foreign_key: true
  end
end
