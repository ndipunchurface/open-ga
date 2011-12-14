class CreateAssemblyDocumentRepositories < ActiveRecord::Migration
  def change
    create_table :assembly_document_repositories do |t|
      t.string :assembly_uuid

      t.timestamps
    end
  end
end
