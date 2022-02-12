class WrDocType < ApplicationRecord
  has_many :wr_doc
  validates :document_name, uniqueness: true
end
