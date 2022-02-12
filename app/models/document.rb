class Document < ApplicationRecord
  acts_as_paranoid
  has_many :document_revision
  has_many :document_distribution
  belongs_to :document_type
  belongs_to :sub_document_type
  belongs_to :document_reference
  belongs_to :document_classification, optional: true
  belongs_to :sub2_document_type, optional: true
  has_many :document_request
  before_create :setStatus

  def setStatus
    if self.status == "Request"
      self.status = self.status
      self.reason = self.reason
    else
      self.status = "Open"
    end
  end

  def self.view_base_type(document_title,document_code,document_date,sub_field,sub_type,sub_document_type_id)
    if document_title.present? and !document_code.present? and !document_date.present?
      left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where('documents.sub_document_type_id = ? and documents.document_title LIKE ? or documents.sub_document_type_id = ? and documents.document_title LIKE ?', sub_type, "%#{document_title.titleize}%", sub_type, "%#{document_title.downcase}%").select('*').order('documents.document_date DESC')
      # expires_in 5.minutes, public: true
    elsif document_code.present? and !document_title.present? and !document_date.present?
      left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where('documents.sub_document_type_id = ? and documents.document_code LIKE ?', sub_type, "%#{document_code}%").select('*').order('documents.document_date DESC')
      # expires_in 5.minutes, public: true
    elsif document_date.present? and !document_title.present? and !document_code.present?
      left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where('documents.sub_document_type_id = ? and documents.document_date = ?', sub_type, "#{document_date}").select('*').order('documents.document_date DESC')
      # expires_in 5.minutes, public: true
    elsif !sub_field.nil?
      left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where(sub_document_type_id: sub_type).select('*').order('documents.document_date DESC')
      # expires_in 5.minutes, public: true
    else
      left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where(sub_document_type_id: sub_document_type_id).select('*').order('documents.document_date DESC')
      # expires_in 5.minutes, public: true
    end
  end

  def self.view2_base_type(document_title,document_code,document_date,sub_field,sub_type,sub2_document_type_id)
    if document_title.present? and !document_code.present? and !document_date.present?
      left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where('documents.sub2_document_type_id = ? and documents.document_title LIKE ? or documents.sub_document_type_id = ? and documents.document_title LIKE ?', sub_type, "%#{document_title.titleize}%", sub_type, "%#{document_title.downcase}%").select('*').order('documents.document_date DESC')
      # expires_in 5.minutes, public: true
    elsif document_code.present? and !document_title.present? and !document_date.present?
      left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where('documents.sub2_document_type_id = ? and documents.document_code LIKE ?', sub_type, "%#{document_code}%").select('*').order('documents.document_date DESC')
      # expires_in 5.minutes, public: true
    elsif document_date.present? and !document_title.present? and !document_code.present?
      left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where('documents.sub2_document_type_id = ? and documents.document_date = ?', sub_type, "#{document_date}").select('*').order('documents.document_date DESC')
      # expires_in 5.minutes, public: true
    elsif !sub_field.nil?
      left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where(sub2_document_type_id: sub_type).select('*').order('documents.document_date DESC')
      # expires_in 5.minutes, public: true
    else
      left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where(sub2_document_type_id: sub2_document_type_id).select('*').order('documents.document_date DESC')
      # expires_in 5.minutes, public: true
    end
  end
end
