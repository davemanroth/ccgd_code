class AddStateIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :state_id, :integer
  end
end
