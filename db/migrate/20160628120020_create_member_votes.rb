class CreateMemberVotes < ActiveRecord::Migration
  def change
    create_table :member_votes do |t|
      t.integer :committee_id
      t.integer :vote_id, index: true
      t.integer :user_id, index:true
      t.text :comment

      t.timestamps null: false
    end
  end
end
