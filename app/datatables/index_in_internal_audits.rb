class IndexInInternalAudits
  delegate :link_to, :current_user, :detail_audit_path, :download_file_audit_path,
           :edit_internal_audit_path, :internal_audit_path,
           :current_user, :params, to: :@view

  require 'date'
  require 'action_view'
  include ActionView::Helpers::DateHelper
  # constructor
  def initialize(view)
    @view = view
    # @coba = parsing //for get params from outside form
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: InternalAudit.count,
        iTotalDisplayRecords: documents.total_entries,
        aaData: data
    }
  end

  private

  def data
    documents.each_with_index.map do |document, index|
      if current_user.is? 6 or current_user.is? 7 or current_user.is? 2
        [
            (index + 1),
            (document.report_no),
            (document.audit_date),
            (document.division),
            (document.fungsi_audit),
            (document.status),
            (document.tindak_lanjut == 1 ? "Ya" : ""),
            link_to('Detail', detail_audit_path(document.idinternalaudits)),
            link_to('Download', download_file_audit_path(document.idinternalaudits)),
            link_to('Edit', edit_internal_audit_path(document.idinternalaudits)),
            link_to('Delete', internal_audit_path(document.idinternalaudits), method: :delete, data: {confirm: 'Are you sure?'})
        ]
      else
        [
            (index + 1),
            (document.report_no),
            (document.audit_date),
            (document.division),
            (document.fungsi_audit),
            (document.status),
            (document.tindak_lanjut == 1 ? "Ya" : ""),
            link_to('Detail', detail_audit_path(document.idinternalaudits)),
            link_to('Download', download_file_audit_path(document.idinternalaudits)),
            (),
            ()
        ]
      end
    end
  end

  def documents
    @documents ||= fetch_documents
  end

  def fetch_documents
    # documents = InternalAudit.left_outer_joins(:followup_audit).select('internal_audits.id AS idinternalaudits, *').order("internal_audits.audit_date DESC")
    documents = InternalAudit.select('internal_audits.id AS idinternalaudits, *').order("internal_audits.audit_date DESC")
    documents = documents.paginate(page: page, per_page: per_page)
    if params[:sSearch].present?
      documents = documents.where("division like :search", search: "%#{params[:sSearch]}%")
    end
    documents
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[report_no audit_date division fungsi_audit status]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] = "desc" ? "desc" : "asc" #ternary operator
  end
end