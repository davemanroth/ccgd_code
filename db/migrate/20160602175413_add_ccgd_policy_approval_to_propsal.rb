class AddCcgdPolicyApprovalToPropsal < ActiveRecord::Migration
  def change
    add_column :proposals, :ccgd_policy_approval, :boolean, default: false
  end
end
