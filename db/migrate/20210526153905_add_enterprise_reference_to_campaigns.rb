class AddEnterpriseReferenceToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_reference :campaigns, :enterprise, null: false, foreign_key: true
  end
end
