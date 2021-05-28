class RemoveDescriptionFromCharityEvents < ActiveRecord::Migration[6.0]
  def change
    # add_column :charity_events, :description, :text
    remove_column :charity_events, :content
  end
end
