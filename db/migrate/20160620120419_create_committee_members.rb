class CreateCommitteeMembers < ActiveRecord::Migration
  def change
    create_table :committee_members do |t|
      t.integer :committee_id
      t.integer :user_id, index: true
      t.integer :vote_id, index: true
      t.text :comment

      t.timestamps null: false
    end
  end
end
