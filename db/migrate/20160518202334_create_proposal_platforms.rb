class CreateProposalPlatforms < ActiveRecord::Migration
  def change
    create_table :proposal_platforms do |t|
      t.integer :proposal_id
      t.integer :platform_id

      t.timestamps null: false
    end
  end
end
