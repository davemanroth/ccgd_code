class RemoveLocationFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :location_id
    end
  end
end
