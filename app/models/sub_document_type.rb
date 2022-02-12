class SubDocumentType < ApplicationRecord
  belongs_to :document_type
  has_many :document
  has_many :document_classification
  has_many :sub2_document_type
  validates :sub_type_name, uniqueness: true
end
