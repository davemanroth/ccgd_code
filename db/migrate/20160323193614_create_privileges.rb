class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.integer :role_id, index: true
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
