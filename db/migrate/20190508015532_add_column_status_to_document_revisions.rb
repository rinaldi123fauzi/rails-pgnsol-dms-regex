class AddColumnStatusToDocumentRevisions < ActiveRecord::Migration[5.0]
  def change
    add_column :document_revisions, :status, :string
  end
end
