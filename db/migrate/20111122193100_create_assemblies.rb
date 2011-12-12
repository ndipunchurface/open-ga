class CreateAssemblies < ActiveRecord::Migration
  def change
    create_table :assemblies, :id => false do |t|
      t.string :uuid, :limit => 36, :primary_key => true
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
