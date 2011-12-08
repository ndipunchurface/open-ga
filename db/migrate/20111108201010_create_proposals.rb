class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :assembly_uuid
      t.integer :user_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
