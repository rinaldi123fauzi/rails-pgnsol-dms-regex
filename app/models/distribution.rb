class Distribution < ApplicationRecord
  belongs_to :document, optional: true
  belongs_to :internal_audit, optional: true
end
