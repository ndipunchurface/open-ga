class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.integer :flaggable_id
      t.string :flaggable_type
      t.integer :user_id

      t.timestamps
    end
  end
end
