class AddMemberRoleToMemberVotes < ActiveRecord::Migration
  def change
    add_column :member_votes, :member_role, :integer
  end
end
