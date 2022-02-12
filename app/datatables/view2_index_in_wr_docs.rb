class View2IndexInWrDocs
  delegate :link_to, :view_show_wr_docs_path, :wr_view_document_path,
           :new_wr_request_path, :edit_wr_doc_path, :soft_delete_wr_docs_path,
           :current_user, :params, to: :@view

  require 'date'
  require 'action_view'
  include ActionView::Helpers::DateHelper
  # constructor
  def initialize(view, document)
    @view = view
    @document = document
    # @coba = parsing //for get params from outside form
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: WrDoc.count,
        iTotalDisplayRecords: documents.total_entries,
        aaData: data
    }
  end

  private

  def data
    documents.each_with_index.map do |document, index|
      if current_user.is? 7 or current_user.is? 2
        [
            (index + 1),
            (document.document_title),
            (document.document_code),
            (document.revision),
            (document.sifat),
            (document.date ? document.date.strftime('%d %b %Y') : ""),
            document.save_date ? (distance_of_time_in_words(Time.now, document.save_date, true, :only => [:years, :months, :weeks, :days])) : (),
            document.keterangan ? (document.keterangan) : (),
            link_to('Detail', view_show_wr_docs_path(document.wr_doc_id), data: {remote: true}),
            link_to('View', wr_view_document_path(document.wr_doc_id), data: {remote: true}),
            link_to('Edit', edit_wr_doc_path(document)),
            link_to('Delete', soft_delete_wr_docs_path(document), data: {confirm: 'Are you sure?'})
        ]
      elsif current_user.is? 19
        if document.issued_by == current_user.nama
          [
            (index + 1),
            (document.document_title),
            (document.document_code),
            (document.revision),
            (document.sifat),
            (document.date ? document.date.strftime('%d %b %Y') : ""),
            document.save_date ? (distance_of_time_in_words(Time.now, document.save_date, true, :only => [:years, :months, :weeks, :days])) : (),
            document.keterangan ? (document.keterangan) : (),
            link_to('Detail', view_show_wr_docs_path(document.wr_doc_id), data: {remote: true}),
            link_to('View', wr_view_document_path(document.wr_doc_id), data: {remote: true}),
            link_to('Edit', edit_wr_doc_path(document)),
            link_to('Delete', soft_delete_wr_docs_path(document), data: {confirm: 'Are you sure?'})
          ]
        else
          [
            (index + 1),
            (document.document_title),
            (document.document_code),
            (document.revision),
            (document.sifat),
            (document.date ? document.date.strftime('%d %b %Y') : ""),
            document.save_date ? (distance_of_time_in_words(Time.now, document.save_date, true, :only => [:years, :months, :weeks, :days])) : (),
            document.keterangan ? (document.keterangan) : (),
            link_to('Detail', view_show_wr_docs_path(document.wr_doc_id), data: {remote: true}),
            link_to('View', wr_view_document_path(document.wr_doc_id), data: {remote: true}),
            (),
            ()
          ]
        end
      elsif current_user.is? 10
        [
            (index + 1),
            (document.document_title),
            (document.document_code),
            (document.revision),
            (document.sifat),
            (document.date ? document.date.strftime('%d %b %Y') : ""),
            document.save_date ? (distance_of_time_in_words(Time.now, document.save_date, true, :only => [:years, :months, :weeks, :days])) : (),
            document.keterangan ? (document.keterangan) : (),
            link_to('Detail', view_show_wr_docs_path(document.wr_doc_id), data: {remote: true}),
            link_to('View', wr_view_document_path(document.wr_doc_id), data: {remote: true}),
            document.description_field == "REFERENSI PGN" ? ("REFERENSI PGN") : link_to('Request', new_wr_request_path(document.wr_doc_id))
        ]
      elsif current_user.is? 6
        [
            (index + 1),
            (document.document_title),
            (document.document_code),
            (document.revision),
            (document.sifat),
            (document.date ? document.date.strftime('%d %b %Y') : ""),
            document.save_date ? (distance_of_time_in_words(Time.now, document.save_date, true, :only => [:years, :months, :weeks, :days])) : (),
            document.keterangan ? (document.keterangan) : (),
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
    documents = WrDoc.left_outer_joins(:sub_field, :field, :wr_doc_type, :sub2_field).where('wr_docs.sub2_field_id = ?', params[:sub2_field_id]).select('*').order("wr_docs.document_code asc, #{sort_column} #{sort_direction}, wr_docs.date DESC")
    documents = documents.paginate(page: page, per_page: per_page)
    if params[:document].present?
      begin
        Date.strptime(params[:document])
        documents = documents.where('wr_docs.date = ?', "#{params[:document]}")
      rescue ArgumentError
        # handle invalid date
        documents = documents.where('lower(wr_docs.document_title) LIKE ? or lower(wr_docs.document_code) LIKE ?', "%#{params[:document].downcase}%", "%#{params[:document].downcase}%")
      end
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
    columns = %w[document_title document_code revision sifat date save_date keterangan]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] = "desc" ? "desc" : "asc" #ternary operator
  end
end