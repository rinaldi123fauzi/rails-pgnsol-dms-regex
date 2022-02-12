class DocumentType < ApplicationRecord
  has_many :sub_document_type
  has_many :document
  validates :type_name, uniqueness: true
end
