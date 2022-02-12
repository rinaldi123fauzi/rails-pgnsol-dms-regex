class CreateCategoryOfFindings < ActiveRecord::Migration[5.0]
  def change
    create_table :category_of_findings do |t|
      t.string :category_name

      t.timestamps
    end
  end
end
