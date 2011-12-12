class CreateAliases < ActiveRecord::Migration
  def change
    create_table :aliases do |t|
      t.string :assembly_uuid
      t.string :name

      t.timestamps
    end
  end
end
