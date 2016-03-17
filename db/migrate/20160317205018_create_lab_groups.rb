class CreateLabGroups < ActiveRecord::Migration
  def change
    create_table :lab_groups do |t|
      t.string :name
      t.string :code

      t.timestamps null: false
    end
  end
end
