class CreateAssemblies < ActiveRecord::Migration
  def change
    create_table :assemblies do |t|
      t.string :uuid
      t.string :name
      t.text :description
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
