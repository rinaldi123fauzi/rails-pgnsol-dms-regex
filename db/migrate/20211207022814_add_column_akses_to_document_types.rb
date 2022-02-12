class AddColumnAksesToDocumentTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :document_types, :akses, :string
  end
end
