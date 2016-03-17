class AddAddressIdToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :address_id, :integer
  end
end
