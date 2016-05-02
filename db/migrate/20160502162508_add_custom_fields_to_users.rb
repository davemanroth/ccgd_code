class AddCustomFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_custom_labgroup_id, :integer
    add_column :users, :user_custom_organization_id, :integer
  end
end
