class CreateUsersLabGroups < ActiveRecord::Migration
  def change
    create_table :users_lab_groups, id: false do |t|
      t.references :users, null: false
      t.references :lab_groups, null: false
    end
  end
end
