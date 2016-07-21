class CreateProposalSampleTypes < ActiveRecord::Migration
  def change
    create_table :proposal_sample_types do |t|
      t.integer :proposal_id, index: true
      t.integer :sample_type_id, index: true

      t.timestamps null: false
    end
  end
end
