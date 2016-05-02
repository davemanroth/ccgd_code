class CreateUserCustomOrganizations < ActiveRecord::Migration
  def change
    create_table :user_custom_organizations do |t|
      t.string :custom_org_name
      t.string :custom_org_phone
      t.string :custom_org_email
      t.string :custom_org_street
      t.string :custom_org_city
      t.string :custom_org_country
      t.integer :state_id

      t.timestamps null: false
    end
  end
end
