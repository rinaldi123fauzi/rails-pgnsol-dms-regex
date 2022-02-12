class Field < ApplicationRecord
has_many :sub_field
has_many :wr_doc
validates :description_field, uniqueness: true
end
