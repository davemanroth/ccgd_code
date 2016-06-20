class CreateCommittees < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.integer :proposal_id, index: true
      t.datetime :deadline

      t.timestamps null: false
    end
  end
end
