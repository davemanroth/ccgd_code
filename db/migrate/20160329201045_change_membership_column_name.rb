class ChangeMembershipColumnName < ActiveRecord::Migration
  def change
    change_table :memberships do |t|
      t.rename :labgroup_id, :lab_group_id
    end
  end
end
