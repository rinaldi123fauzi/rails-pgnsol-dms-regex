class Sub4Field < ApplicationRecord
  belongs_to :sub3_field
  has_many :wr_doc
end
