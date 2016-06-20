class CreateCommitteeMembers < ActiveRecord::Migration
  def change
    create_table :committee_members do |t|
      t.integer :committee_id
      t.integer :user_id
      t.integer :vote_id
      t.text :comment

      t.timestamps null: false
    end
  end
end
