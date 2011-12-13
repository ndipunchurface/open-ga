class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :user_id
      t.string :assembly_uuid
      t.integer :role

      t.timestamps
    end
  end
end
