class CreateBindingVotes < ActiveRecord::Migration
  def change
    create_table :binding_votes do |t|
      t.integer :user_id
      t.integer :bindable_id
      t.string :bindable_type

      t.timestamps
    end
  end
end
