class Sub3Field < ApplicationRecord
  has_many :wr_doc
  has_many :sub4_field
  belongs_to :sub2_field
end
