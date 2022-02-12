class SubField < ApplicationRecord
  belongs_to :field
  has_many :wr_doc
  has_many :sub2_field
  validates :description_sub_field, uniqueness: true
end
