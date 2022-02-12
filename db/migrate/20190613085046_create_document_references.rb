class CreateDocumentReferences < ActiveRecord::Migration[5.0]
  def change
    create_table :document_references do |t|
      t.string :reference_name

      t.timestamps
    end
  end
end
