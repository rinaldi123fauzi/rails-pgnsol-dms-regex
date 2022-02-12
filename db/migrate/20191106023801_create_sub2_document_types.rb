class CreateSub2DocumentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :sub2_document_types do |t|
      t.integer :sub_document_type_id
      t.string :sub2_type_name

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE sub2_document_types
        ADD CONSTRAINT sub_document_types
        FOREIGN KEY (sub_document_type_id)
        REFERENCES sub_document_types(sub_document_type_id)
    SQL
  end
end
