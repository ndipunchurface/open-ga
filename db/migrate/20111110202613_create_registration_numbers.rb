class CreateRegistrationNumbers < ActiveRecord::Migration
  def change
    create_table :registration_numbers, :id => false do |t|
      t.string :id, :primary => true
      t.boolean :active

      t.timestamps
    end
  end
end
