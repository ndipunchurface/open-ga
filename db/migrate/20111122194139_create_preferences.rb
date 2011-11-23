class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :preferable_id
      t.string :preferable_type
      t.string :name
      t.text :data

      t.timestamps
    end
  end
end
