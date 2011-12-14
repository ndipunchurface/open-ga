class CreateAssemblies < ActiveRecord::Migration
  def change
    create_table :assemblies, :id => false do |t|
      t.string :uuid, :limit => 36, :primary_key => true
      t.integer :user_id
      t.string :name, :null => false
      t.integer :assembly_category_id, :null => false
      t.text :description
      t.string :city
      t.string :state
      t.string :zip
      
      ## Preferences
      t.integer :super_majority, :default => 66
      t.string :theme, :default => "default"
      t.string :web_address
      t.string :public_email
      t.string :public_phone
      t.integer :flag_threshold, :defualt => 3
      t.integer :block_threshold, :default => 5

      t.timestamps
    end
  end
end
