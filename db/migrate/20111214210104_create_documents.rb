class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :documentable_id
      t.string :documentable_type
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
