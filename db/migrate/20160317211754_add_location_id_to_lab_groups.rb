class AddLocationIdToLabGroups < ActiveRecord::Migration
  def change
    add_column :lab_groups, :location_id, :integer
  end
end
