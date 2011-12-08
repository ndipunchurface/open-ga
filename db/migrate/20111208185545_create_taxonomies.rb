class CreateTaxonomies < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
      t.integer :taggable_id
      t.string :taggable_type
      t.integer :tag_id
      t.string :assembly_uuid

      t.timestamps
    end
  end
end
