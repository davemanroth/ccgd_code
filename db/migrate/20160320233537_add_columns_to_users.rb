class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :organization_id, :integer
    add_column :users, :location_id, :integer
    add_column :users, :status, :string, limit: 2
  end
end
