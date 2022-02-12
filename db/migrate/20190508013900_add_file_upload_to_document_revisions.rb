class AddFileUploadToDocumentRevisions < ActiveRecord::Migration[5.0]
  def change
    add_column :document_revisions, :file_upload, :string
  end
end
