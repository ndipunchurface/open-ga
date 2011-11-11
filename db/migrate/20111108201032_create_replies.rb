class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.integer :replyable_id
      t.string :replyable_type
      t.text :body

      t.timestamps
    end
  end
end
