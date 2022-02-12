class Sub2DocumentType < ApplicationRecord
  belongs_to :sub_document_type
  has_many :document
  # validates :sub2_type_name, uniqueness: true
end
