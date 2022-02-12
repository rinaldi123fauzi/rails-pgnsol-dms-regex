class WrDoc < ApplicationRecord
  acts_as_paranoid
  belongs_to :field
  belongs_to :sub_field
  belongs_to :wr_doc_type
  has_many :wr_doc_request
  has_many :wr_doc_revision
  has_many :wr_doc_distribution
  belongs_to :sub2_field, optional: true
  belongs_to :sub3_field, optional: true
  belongs_to :sub4_field, optional: true
end
