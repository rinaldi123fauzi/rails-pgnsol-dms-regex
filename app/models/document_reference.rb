class DocumentReference < ApplicationRecord
  has_many :document
  validates :reference_name, uniqueness: true
end
