class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :proposal_id
      t.integer :user_id

      t.timestamps
    end
  end
end
