class ViewBaseTypeInDocuments
  delegate :link_to, :view_show_documents_path, :view_document_path,
           :new_request_path, :edit_document_path, :soft_delete_documents_path,
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
        iTotalRecords: Document.count,
        iTotalDisplayRecords: documents.total_entries,
        aaData: data
    }
  end

  private

  def data
    documents.each_with_index.map do |document, index|
      if current_user.is? 6 or current_user.is? 2
        [
            (index + 1),
            (document.document_title),
            (document.document_code),
            (document.classification_name),
            (document.revision),
            (document.sifat),
            document.document_date ? (document.document_date.strftime('%d %b %Y')) : (),
            document.save_date ? (distance_of_time_in_words(Time.now, document.save_date, true, :only => [:years, :months, :weeks, :days])) : (),
            document.keterangan ? (document.keterangan) : (),
            link_to('Detail', view_show_documents_path(document.document_id), data: {remote: true}),
            link_to('View', view_document_path(document.document_id), data: {remote: true}),
            link_to('Edit', edit_document_path(document)),
            link_to('Delete', soft_delete_documents_path(document), data: {confirm: 'Are you sure?'})
        ]
      elsif current_user.is? 10
        [
            (index + 1),
            (document.document_title),
            (document.document_code),
            (document.classification_name),
            (document.revision),
            (document.sifat),
            document.document_date ? (document.document_date.strftime('%d %b %Y')) : (),
            document.save_date ? (distance_of_time_in_words(Time.now, document.save_date, true, :only => [:years, :months, :weeks, :days])) : (),
            document.keterangan ? (document.keterangan) : (),
            link_to('Detail', view_show_documents_path(document.document_id), data: {remote: true}),
            link_to('View', view_document_path(document.document_id), data: {remote: true}),
            link_to('Request', new_request_path(document.document_id))
        ]
      elsif current_user.is? 7
        [
            (index + 1),
            (document.document_title),
            (document.document_code),
            (document.classification_name),
            (document.revision),
            (document.sifat),
            document.document_date ? (document.document_date.strftime('%d %b %Y')) : (),
            document.save_date ? (distance_of_time_in_words(Time.now, document.save_date, true, :only => [:years, :months, :weeks, :days])) : (),
            document.keterangan ? (document.keterangan) : (),
            (),
            ()
        ]
      elsif current_user.is? 21
        if document.issued_by == current_user.nama
          [
            (index + 1),
            (document.document_title),
            (document.document_code),
            (document.classification_name),
            (document.revision),
            (document.sifat),
            document.document_date ? (document.document_date.strftime('%d %b %Y')) : (),
            document.save_date ? (distance_of_time_in_words(Time.now, document.save_date, true, :only => [:years, :months, :weeks, :days])) : (),
            document.keterangan ? (document.keterangan) : (),
            link_to('Detail', view_show_documents_path(document.document_id), data: {remote: true}),
            link_to('View', view_document_path(document.document_id), data: {remote: true}),
            link_to('Edit', edit_document_path(document)),
            link_to('Delete', soft_delete_documents_path(document), data: {confirm: 'Are you sure?'})
          ]
        else
          [
            (index + 1),
            (document.document_title),
            (document.document_code),
            (document.classification_name),
            (document.revision),
            (document.sifat),
            document.document_date ? (document.document_date.strftime('%d %b %Y')) : (),
            document.save_date ? (distance_of_time_in_words(Time.now, document.save_date, true, :only => [:years, :months, :weeks, :days])) : (),
            document.keterangan ? (document.keterangan) : (),
            link_to('Detail', view_show_documents_path(document.document_id), data: {remote: true}),
            link_to('View', view_document_path(document.document_id), data: {remote: true}),
            (),
            ()
          ]
        end
      end
    end
  end

  def documents
    @documents ||= fetch_documents
  end

  def fetch_documents
    documents = Document.left_outer_joins(:document_type, :sub_document_type, :document_reference, :document_classification, :sub2_document_type).where('documents.sub_document_type_id = ?', params[:sub_document_type_id]).select('*').order("documents.document_code ASC")
    documents = documents.paginate(page: page, per_page: per_page)
    if params[:document].present?
      begin
        Date.strptime(params[:document])
        documents = documents.where('documents.document_date = ?', "#{params[:document]}")
      rescue ArgumentError
        # handle invalid date
        documents = documents.where('lower(documents.document_title) LIKE ? or lower(documents.document_code) LIKE ?', "%#{params[:document].downcase}%", "%#{params[:document].downcase}%")
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
    columns = %w[document_title document_code revision sifat document_date save_date keterangan]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] = "desc" ? "desc" : "asc" #ternary operator
  end
end