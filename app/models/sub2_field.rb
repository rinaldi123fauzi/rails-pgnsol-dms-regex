class Sub2Field < ApplicationRecord
  belongs_to :sub_field
  has_many :sub3_field
  has_many :wr_doc
end
