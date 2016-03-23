class DropUsersLabGroups < ActiveRecord::Migration
  def change
    drop_table :users_lab_groups
  end
end
