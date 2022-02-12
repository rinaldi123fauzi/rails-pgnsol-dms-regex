class LogActivity < ApplicationRecord
  belongs_to :member

  def self.list_login
    LogActivity.joins(:member).select('*').where('controller = ? and action = ?', "sessions", "create").order('activity_date DESC')
  end

  def self.list_request
    left_outer_joins(:member).where('controller = ? and action = ? or controller = ? and action = ?', "document_requests", "create", "wr_doc_requests", "create").select('*').order('log_activities.activity_date DESC')
  end
end
