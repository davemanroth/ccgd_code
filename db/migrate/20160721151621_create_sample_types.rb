class CreateSampleTypes < ActiveRecord::Migration
  def change
    create_table :sample_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
