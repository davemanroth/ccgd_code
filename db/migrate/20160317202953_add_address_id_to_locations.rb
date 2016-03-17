class AddAddressIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :address_id, :integer
  end
end
