class AddReferencesToPrivilege < ActiveRecord::Migration
  def change
    change_table :privileges do |t|
      t.remove :user_id, :role_id
      t.references :user, index: true, null: false
      t.references :role, index: true, null: false
    end
  end
end
