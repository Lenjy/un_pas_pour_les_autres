class AddEnterpriseIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :enterprise, null: false, foreign_key: true
  end
end
