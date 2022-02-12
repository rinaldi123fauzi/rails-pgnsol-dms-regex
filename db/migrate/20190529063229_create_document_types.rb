class CreateDocumentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :document_types do |t|
      t.string :document_name
      t.string :desc_document

      t.timestamps
    end
  end
end
