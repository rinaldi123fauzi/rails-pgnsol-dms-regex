class DocumentClassification < ApplicationRecord
  belongs_to :sub_document_type
  has_many :document
  validates :classification_name, uniqueness: true
end
