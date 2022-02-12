class CreateCpars < ActiveRecord::Migration[5.0]
  def change
    create_table :cpars do |t|
      t.string :cpar_no
      t.integer :ncr_id
      t.date :issued_date
      t.string :request
      t.string :to_responsible_discipline
      t.string :issued_by
      t.string :checked
      t.string :approved
      t.string :project_manager
      t.string :category
      t.string :potential_risk
      t.string :root_cause
      t.string :propose_corrective_action
      t.string :resources_required_corrective
      t.date :evective_corrective_date
      t.string :person_in_charge_corrective
      t.string :propose_preventive_action
      t.string :resources_required_preventive
      t.date :evective_preventive_date
      t.string :person_in_charge_preventive

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE cpars
        ADD CONSTRAINT ncrs
        FOREIGN KEY (ncr_id)
        REFERENCES ncrs(ncr_id)
    SQL
  end
end
