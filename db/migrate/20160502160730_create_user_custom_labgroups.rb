class CreateUserCustomLabgroups < ActiveRecord::Migration
  def change
    create_table :user_custom_labgroups do |t|
      t.string :custom_labgroup_name
      t.string :custom_labgroup_code
      t.string :custom_labgroup_building
      t.string :custom_labgroup_room
      t.string :custom_street
      t.string :custom_city
      t.string :custom_country
      t.integer :state_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
