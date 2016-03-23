class ChangeMembershipColumnName < ActiveRecord::Migration
  def change
    change_table :memberships do |t|
      t.rename :lab_group_id, :labgroup_id
    end
  end
end
