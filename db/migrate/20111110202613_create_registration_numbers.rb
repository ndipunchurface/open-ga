class CreateRegistrationNumbers < ActiveRecord::Migration
  def change
    create_table :registration_numbers do |t|
      t.string :number
      t.boolean :active

      t.timestamps
    end
  end
end
