class InternalAudit < ApplicationRecord
  has_many :document_distribution
  has_many :document_request
  has_many :followup_audit
end
