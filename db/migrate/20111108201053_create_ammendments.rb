class CreateAmmendments < ActiveRecord::Migration
  def change
    create_table :ammendments do |t|
      t.integer :user_id
      t.integer :proposal_id
      t.text :title
      t.text :body

      t.timestamps
    end
  end
end
