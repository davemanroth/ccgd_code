class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :name
      t.string :code, limit: 10
      t.text :objectives
      t.text :background
      t.text :design_details
      t.text :sample_availability
      t.text :contributions
      t.text :comments
      t.belongs_to(:proposal_status, index: true)
      t.belongs_to(:user, index: true)
      t.belongs_to(:lab_group, index: true)
      t.boolean :submitted, default: false

      t.timestamps null: false
    end
  end
end
