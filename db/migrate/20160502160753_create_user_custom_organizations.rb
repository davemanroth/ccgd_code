class CreateUserCustomOrganizations < ActiveRecord::Migration
  def change
    create_table :user_custom_organizations do |t|
      t.string :custom_org_name
      t.string :custom_org_phone
      t.string :custom_org_email
      t.string :custom_street
      t.string :custom_city
      t.string :custom_country
      t.integer :state_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
