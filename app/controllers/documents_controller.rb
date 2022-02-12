#Developer : Mohamad Rinaldi Fauzi
#DB table : documents
#Module : QMS (Quality Management)
#Sifat Tabel : Transaksi
#Ket : Data dokumen Quality Management
class DocumentsController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  protect_from_forgery with: :exception
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /documents
  # GET /documents.json
  def index_request
    # if current_user.is? 10
    #   # @documents = Distribution.joins(:document).where('distributions.receiver = ? and distributions.status = ? and documents.reason = ?', current_user.nama, "Received", "").select('*').order('documents.document_date DESC')
    #   # @documents = Distribution.joins(:document).where('distributions.receiver = ? and distributions.status = ?', current_user.nama, "Approved").select('*').order('documents.document_date DESC')
    #   @documents = Document.joins(:document_reference).select('*').order('document_date DESC')
    # else
    # abort params[:document_date].inspect
    if !params[:document_title].nil? and !params[:document_code].present? and !params[:document_date].present?
      @documents = Document.joins(:document_type, :sub_document_type, :document_reference).select('*').where('documents.document_title LIKE ? or documents.document_title LIKE ?', "%#{params[:document_title].titleize}%", "%#{params[:document_title].downcase}%").order('documents.document_date DESC')
    elsif !params[:document_code].nil? and !params[:document_date].present? and !params[:document_title].present?
      @documents = Document.joins(:document_type, :sub_document_type, :document_reference).select('*').where('documents.document_code LIKE ?', "%#{params[:document_code]}%").order('documents.document_date DESC')
    elsif !params[:document_code].present? and !params[:document_date].nil? and !params[:document_title].present?
      @documents = Document.joins(:document_type, :sub_document_type, :document_reference).select('*').where('documents.document_date = ?', "#{params[:document_date]}").order('documents.document_date DESC')
    else
      @documents = Document.joins(:document_type, :sub_document_type, :document_reference).select('*').order('documents.document_date DESC')
    end
    # end
  end

  def report_corporate
    # @documents = Document.left_outer_joins(:document_classification).group('documents.document_id, document_classifications.classification_name').select('documents.*', "(GROUP BY document_code HAVING COUNT(*)>1) as dodol").order("penanggung_jawab, classification_name, CASE WHEN dodol == true THEN 'document_code ASC, document_date ASC' ELSE 'document_date ASC, document_code ASC' END")
    # @documents = Document.left_outer_joins(:document_classification).select("*").order("penanggung_jawab, classification_name, CASE  WHEN keterangan = 'Dimusnahkan' AND documents.document_code = " + "'#{f.document_code}'" + " THEN 'document_code ASC, document_date DESC' ELSE 'document_code ASC, document_date ASC' END")
    # CASE WHEN document_code = 'Dimusnahkan' THEN 'select document_code from documents where documents.document_code = Dimusnahkan order_by(penanggung_jawab, classification_name, document_date DESC)' ELSE 'document_date DESC' END,
    # @dodol = Document.select('documents.document_code').group('documents.document_code')
    # @dodol.each do |f|
    @documents = Document.left_outer_joins(:document_classification).where(document_type_id: params[:document_type_id]).select("*").order("penanggung_jawab, classification_name, document_code, document_id, save_location, document_title, revision ASC")
    # end
    respond_to do |format|
      format.html { head :no_content }
      format.pdf do
        # render :orientation => 'Landscape',:encoding => "utf8", :layout => "pdf_layout", pdf: "assessment_pdf.pdf"
        render :orientation => 'Landscape', :encoding => "utf8", :layout => "pdf_layout", pdf: "reportQMS_DAK_" + Time.now.strftime('%Y%m%d%H%I%S'), :footer => {:right => '[page] of [topage]', :font_size => 8}, margin: {bottom: 4,
                                                                                                                                                                                                                            left: 2,
                                                                                                                                                                                                                            right: 2}
        # render :orientation => 'Portrait',:encoding => "utf8", :layout => "pdf_layout", pdf: "reportQMS_" + Time.now.strftime('%Y%m%d%H%I%S') + ".pdf"
      end
    end
  end

  def report_dak
    # @documents = Document.left_outer_joins(:document_classification).group('documents.document_id, document_classifications.classification_name').select('documents.*', "(GROUP BY document_code HAVING COUNT(*)>1) as dodol").order("penanggung_jawab, classification_name, CASE WHEN dodol == true THEN 'document_code ASC, document_date ASC' ELSE 'document_date ASC, document_code ASC' END")
    # @documents = Document.left_outer_joins(:document_classification).select("*").order("penanggung_jawab, classification_name, CASE  WHEN keterangan = 'Dimusnahkan' AND documents.document_code = " + "'#{f.document_code}'" + " THEN 'document_code ASC, document_date DESC' ELSE 'document_code ASC, document_date ASC' END")
    # CASE WHEN document_code = 'Dimusnahkan' THEN 'select document_code from documents where documents.document_code = Dimusnahkan order_by(penanggung_jawab, classification_name, document_date DESC)' ELSE 'document_date DESC' END,
    # @dodol = Document.select('documents.document_code').group('documents.document_code')
    # @dodol.each do |f|
    @documents = Document.left_outer_joins(:document_classification).where(document_type_id: params[:document_type_id]).select("*").order("keterangan, penanggung_jawab, classification_name, document_code, document_id, save_location, document_title, revision ASC")
    # end
    respond_to do |format|
      format.html { head :no_content }
      format.pdf do
        # render :orientation => 'Landscape',:encoding => "utf8", :layout => "pdf_layout", pdf: "assessment_pdf.pdf"
        render :orientation => 'Landscape', :encoding => "utf8", :layout => "pdf_layout", pdf: "reportQM_DAK_" + Time.now.strftime('%Y%m%d%H%I%S'), :footer => {:right => '[page] of [topage]', :font_size => 8}, margin: {bottom: 4,
                                                                                                                                                                                                                           left: 2,
                                                                                                                                                                                                                           right: 2}
        # render :orientation => 'Portrait',:encoding => "utf8", :layout => "pdf_layout", pdf: "reportQMS_" + Time.now.strftime('%Y%m%d%H%I%S') + ".pdf"
      end
    end
  end

  def report
    # @documents = Document.left_outer_joins(:document_classification).group('documents.document_id, document_classifications.classification_name').select('documents.*', "(GROUP BY document_code HAVING COUNT(*)>1) as dodol").order("penanggung_jawab, classification_name, CASE WHEN dodol == true THEN 'document_code ASC, document_date ASC' ELSE 'document_date ASC, document_code ASC' END")
    # @documents = Document.left_outer_joins(:document_classification).select("*").order("penanggung_jawab, classification_name, CASE  WHEN keterangan = 'Dimusnahkan' AND documents.document_code = " + "'#{f.document_code}'" + " THEN 'document_code ASC, document_date DESC' ELSE 'document_code ASC, document_date ASC' END")
    # CASE WHEN document_code = 'Dimusnahkan' THEN 'select document_code from documents where documents.document_code = Dimusnahkan order_by(penanggung_jawab, classification_name, document_date DESC)' ELSE 'document_date DESC' END,
    # @dodol = Document.select('documents.document_code').group('documents.document_code')
    # @dodol.each do |f|
    @documents = Document.left_outer_joins(:document_classification).select("*").order("penanggung_jawab, classification_name, document_code, document_id, save_location, document_title, revision ASC")
    # end
    respond_to do |format|
      format.html { head :no_content }
      format.pdf do
        # render :orientation => 'Landscape',:encoding => "utf8", :layout => "pdf_layout", pdf: "assessment_pdf.pdf"
        render :orientation => 'Landscape', :encoding => "utf8", :layout => "pdf_layout", pdf: "reportQMS_" + Time.now.strftime('%Y%m%d%H%I%S'), :footer => {:right => '[page] of [topage]', :font_size => 8}, margin: {bottom: 4,
                                                                                                                                                                                                                        left: 2,
                                                                                                                                                                                                                        right: 2}
        # render :orientation => 'Portrait',:encoding => "utf8", :layout => "pdf_layout", pdf: "reportQMS_" + Time.now.strftime('%Y%m%d%H%I%S') + ".pdf"
      end
    end
  end

  def view_document
    if current_user.username.present?
      ldap = Net::LDAP.new :host => '192.168.60.159',
                           :port => 389,
                           :auth => {
                               :method => :simple,
                               :username => "cn=manager, dc=pgn-solution, dc=co, dc=id",
                               :password => "4lh4mdul1ll4h"
                           }
      filter = Net::LDAP::Filter.eq("cn", "#{current_user.username}")
      treebase = "dc=pgn-solution, dc=co, dc=id"
      ldap.search(:base => treebase, :filter => filter) do |entry|
        if current_user.username == entry["sn"].map(&:inspect).join(', ').gsub('"', '')
          # login_activity current_user.nama + " has been logout "
          @document = Document.find(params[:document_id])
          create_user_activity @document.document_code, current_user.nama + " has been viewing document with title : " + @document.document_title
        end
      end
    end
    #code
  end

  def home
    #code
  end

  def view_base_type
    @document_title = params[:document_title]
    @document_code = params[:document_code]
    @document_date = params[:document_date]
    @sub_field = params[:sub_field]
    @sub_document_type_id = params[:sub_document_type_id]

    #try catch
    @documentType = SubDocumentType.find_by(sub_document_type_id: @sub_document_type_id)
    unless @documentType.present?
      render_404
    end

    if @document_title.present?
      respond_to do |format|
        format.html
        @document = params[:document_title]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewBaseTypeInDocuments.new(view_context, {document: @document}) }
      end
    elsif @document_date.present?
      respond_to do |format|
        format.html
        @document = params[:document_date]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewBaseTypeInDocuments.new(view_context, {document: @document}) }
      end
    elsif @document_code.present?
      respond_to do |format|
        format.html
        @document = params[:document_code]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewBaseTypeInDocuments.new(view_context, {document: @document}) }
      end
    elsif !@sub_field.nil?
      respond_to do |format|
        format.html
        @document = nil
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewBaseTypeInDocuments.new(view_context, {document: @document}) }
      end
    else
      respond_to do |format|
        format.html
        @document = nil
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewBaseTypeInDocuments.new(view_context, {document: @document}) }
      end
    end
  end

  def sub_home_qms
    @document_type_id = params[:document_type_id]
    @name = DocumentType.find_by(document_type_id: @document_type_id)
    @field = SubDocumentType.where(document_type_id: @document_type_id).select('*').order('sub_type_name ASC')
    expires_in 5.minutes, public: true
    unless @name.present? and @field.exists?
      render_404
    end
  end

  def sub2_home_qms
    @sub_document_type_id = params[:sub_document_type_id]
    @name = SubDocumentType.find_by(sub_document_type_id: @sub_document_type_id)
    @field = Sub2DocumentType.where(sub_document_type_id: @sub_document_type_id).select('*').order('sub2_type_name ASC')
    expires_in 5.minutes, public: true
    unless @name.present? and @field.exists?
      render_404
    end
  end

  def view2_base_type
    @document_title = params[:document_title]
    @document_code = params[:document_code]
    @document_date = params[:document_date]
    @sub_field = params[:sub_field]
    @sub_document_type_id = params[:sub2_document_type_id]

    #try catch
    @documentType = Sub2DocumentType.find_by(sub2_document_type_id: @sub_document_type_id)
    unless @documentType.present?
      render_404
    end

    if @document_title.present?
      respond_to do |format|
        format.html
        @document_coba = @document_title
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View2BaseTypeInDocuments.new(view_context, {document_coba: @document_coba}) }
      end
    elsif @document_code.present?
      respond_to do |format|
        format.html
        @document_coba = @document_code
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View2BaseTypeInDocuments.new(view_context, {document_coba: @document_coba}) }
      end
    elsif @document_date.present?
      respond_to do |format|
        format.html
        @document_coba = @document_date
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View2BaseTypeInDocuments.new(view_context, {document_coba: @document_coba}) }
      end
    else
      respond_to do |format|
        format.html
        @document = nil
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View2BaseTypeInDocuments.new(view_context, {document_coba: @document_coba}) }
      end
    end
  end

  def home_qms
    @field = DocumentType.all.order("type_name ASC").page(params[:page]).per_page(6)
    @custom_paginate_renderer = custom_paginate_renderer
  end

  def document_approval
    @documents = Document.where("reason = ? and approve = ? ", "", current_user.nama).select('*')
  end

  def document_approve_request
    @documents = Document.where.not(reason: "").select('*')
  end

  def document_check
    # @documents = Document.joins(:wr_doc).where('status = ? or status = ?', 'Open', 'Request').select('*')
    # @documents = Document.where(checker: current_user.nama).select('*')
    @documents = Document.joins(:document_type, :sub_document_type, :document_reference).select('*').order('document_date DESC')
  end

  def document_distribution
    # @documents = Document.joins(:wr_doc).where('status = ? or status = ?', 'Open', 'Request').select('*')
    @documents = Document.select('*')
  end

  def document_request
    # if current_user.is? 10
    #   @documents = Distribution.joins(:document).where('distributions.receiver = ? and distributions.status = ?', current_user.nama, "Received").where.not('documents.reason = ?', "").select('*')
    # else
    #   @documents = Document.where.not(reason: "").select('*')
    # end
    if current_user.is? 10
      @documents = Document.joins(:document_reference).select('*')
    else
      @documents = DocumentRequest.joins(:document).select('*')
    end
  end

  def do_approval
    @document = Document.find(params[:id])
    # abort @document.document_title.inspect
    @document.update(document_code: "#{@document.document_code}")
    @document.update(document_seq_no: "#{@document.document_seq_no}")
    @document.update(document_date: "#{@document.document_date}")
    @document.update(document_title: "#{@document.document_title}")
    @document.update(revision: "#{@document.revision}")
    @document.update(issued_by: "#{@document.issued_by}")
    nama = Member.find_by(member_id: current_user.member_id)
    @document.update(approved_by: "#{nama.nama}")
    @document.update(status: "Done")
    if @document.reason.present?
      redirect_to document_approve_request_documents_path, notice: 'Document was successfully to approve.'
    else
      redirect_to document_approval_documents_path, notice: 'Document was successfully to approve.'
    end
  end

  def recycle_bin
    # if current_user.is? 10
    #   # @documents = Distribution.joins(:document).where('distributions.receiver = ? and distributions.status = ? and documents.reason = ?', current_user.nama, "Received", "").select('*').order('documents.document_date DESC')
    #   # @documents = Distribution.joins(:document).where('distributions.receiver = ? and distributions.status = ?', current_user.nama, "Approved").select('*').order('documents.document_date DESC')
    #   @documents = Document.joins(:document_reference).select('*').order('document_date DESC')
    # else
    # abort params[:document_date].inspect
    if !params[:document_title].nil? and !params[:document_code].present? and !params[:document_date].present?
      @documents = Document.only_deleted.joins(:document_type, :sub_document_type, :document_reference).select('*').where('documents.document_title LIKE ? or documents.document_title LIKE ?', "%#{params[:document_title].titleize}%", "%#{params[:document_title].downcase}%").order('documents.document_date DESC')
    elsif !params[:document_code].nil? and !params[:document_date].present? and !params[:document_title].present?
      @documents = Document.only_deleted.joins(:document_type, :sub_document_type, :document_reference).select('*').where('documents.document_code LIKE ?', "%#{params[:document_code]}%").order('documents.document_date DESC')
    elsif !params[:document_code].present? and !params[:document_date].nil? and !params[:document_title].present?
      @documents = Document.only_deleted.joins(:document_type, :sub_document_type, :document_reference).select('*').where('documents.document_date = ?', "#{params[:document_date]}").order('documents.document_date DESC')
    else
      @documents = Document.only_deleted.joins(:document_type, :sub_document_type, :document_reference).select('*').order('documents.document_date DESC')
    end
    # end
  end

  def view_all_index
    @document_title = params[:document_title]
    @document_code = params[:document_code]
    @document_date = params[:document_date]

    if @document_title.present?
      respond_to do |format|
        format.html
        @document = params[:document_title]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewAllIndexInDocuments.new(view_context, {document: @document}) }
      end
    elsif @document_date.present?
      respond_to do |format|
        format.html
        @document = params[:document_date]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewAllIndexInDocuments.new(view_context, {document: @document}) }
      end
    elsif @document_code.present?
      respond_to do |format|
        format.html
        @document = params[:document_code]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewAllIndexInDocuments.new(view_context, {document: @document}) }
      end
    else
      respond_to do |format|
        format.html
        @document = nil
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewAllIndexInDocuments.new(view_context, {document: @document}) }
      end
    end
  end

  def document_tracking
    @documents = Document.joins(:document_type, :sub_document_type).select('*')
  end

  def index
    # if !params[:document_title].nil? and !params[:document_code].present? and !params[:document_date].present?
    #   @documents = Document.joins(:document_type, :sub_document_type, :document_reference).select('*').where('documents.document_title LIKE ? or documents.document_title LIKE ?', "%#{params[:document_title].titleize}%", "%#{params[:document_title].downcase}%").order('documents.document_date DESC')
    # elsif !params[:document_code].nil? and !params[:document_date].present? and !params[:document_title].present?
    #   @documents = Document.joins(:document_type, :sub_document_type, :document_reference).select('*').where('documents.document_code LIKE ?', "%#{params[:document_code]}%").order('documents.document_date DESC')
    # elsif !params[:document_code].present? and !params[:document_date].nil? and !params[:document_title].present?
    #   @documents = Document.joins(:document_type, :sub_document_type, :document_reference).select('*').where('documents.document_date = ?', params[:document_date]).order('documents.document_date DESC')
    # else
    #   @documents = Document.joins(:document_type, :sub_document_type, :document_reference).select('*').order('documents.document_date DESC')
    # end
    begin
      render_404
    rescue => exception
      render_404
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def view_show
    @document = Document.left_outer_joins(:document_reference, :document_type, :sub_document_type, :document_classification).where('documents.document_id = ?', params[:document_id]).select('*').order('documents.document_id DESC')
    # @documents.each do |f|
    #   @document_id = f.document_id
    #   @document_code = f.document_code
    #   @document_seq_no = f.document_seq_no
    #   @document_revision = f.revision
    #   @document_title = f.document_title
    #   @document_issued_by = f.issued_by
    #   @document_checked_by = f.checked_by
    #   @document_approved_by = f.approved_by
    #   @document_file_upload = f.file_upload
    #   @document_status = f.status
    #   @document_classification = f.classification_name
    #   @document_date = f.document_date.strftime('%d %b %Y')
    #   @document_reason = f.reason
    #   @sub_type_name = f.sub_type_name
    #   @type_name = f.type_name
    #   @reference_name = f.reference_name
    #   @penanggung_jawab = f.penanggung_jawab
    #   @save_date = f.save_date
    #   @save_location = f.save_location
    #   @sifat = f.sifat
    #
    # end
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    uploaded_io = params[:document][:file_upload]
    file_extention = File.extname(uploaded_io.original_filename)
    unless  params[:document][:document_code].match(/(<|>|alert|function()|dir)/) or 
            params[:document][:document_title].match(/(<|>|alert|function()|dir)/) or
            params[:document][:issued_by].match(/(<|>|alert|function()|dir)/) or
            params[:document][:save_location].match(/(<|>|alert|function()|dir)/) or
            params[:document][:keterangan].match(/(<|>|alert|function()|dir)/) or
            params[:document][:sifat].match(/(<|>|alert|function()|dir)/) or
            params[:document][:penanggung_jawab].match(/(<|>|alert|function()|dir)/)

      unless file_extention.match(/(.pdf|.mp4|.docx|docs)/)
        redirect_to home_qms_documents_path, notice: "Format not allowed"
      else
        respond_to do |format|
          create_user_activity params[:document][:document_code], current_user.nama + " has been inputing document with title : " + params[:document][:document_title]
          @document.file_upload = setUploadFile(params[:document][:file_upload], params[:document][:document_code])
          if @document.save
            format.html { redirect_to view_all_index_documents_path, notice: 'Document was successfully created.' }
            format.json { render :show, status: :created, location: @document }
          else
            format.html { render :new }
            format.json { render json: @document.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      redirect_to home_qms_documents_path, notice: "Format not allowed"
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    unless  params[:document][:document_code].match(/(<|>|alert|function()|dir)/) or 
      params[:document][:document_title].match(/(<|>|alert|function()|dir)/) or
      params[:document][:issued_by].match(/(<|>|alert|function()|dir)/) or
      params[:document][:save_location].match(/(<|>|alert|function()|dir)/) or
      params[:document][:keterangan].match(/(<|>|alert|function()|dir)/) or
      params[:document][:sifat].match(/(<|>|alert|function()|dir)/) or
      params[:document][:penanggung_jawab].match(/(<|>|alert|function()|dir)/)
      
        @change = Document.find(params[:id])
        @change.document_code = params[:document][:document_code]
        @change.document_seq_no = params[:document][:document_seq_no]
        @change.document_date = params[:document][:document_date]
        @change.document_title = params[:document][:document_title]
        @change.document_type_id = params[:document][:document_type_id]
        @change.save_location = "#{params[:document][:save_location]}"
        @change.penanggung_jawab = "#{params[:document][:penanggung_jawab]}"
        @change.save_date = params[:document][:save_date]
        @change.keterangan = params[:document][:keterangan]
        @change.document_classification_id = params[:document][:document_classification_id]
        @change.revision = params[:document][:revision]
        @change.sifat = params[:document][:sifat]
        @change.sub_document_type_id = params[:document][:sub_document_type_id]
        @change.sub2_document_type_id = params[:document][:sub2_document_type_id]
        @change.document_reference_id = params[:document][:document_reference_id]
        create_user_activity params[:document][:document_code], current_user.nama + " has been editing document with title : " + params[:document][:document_title] + " Changed : " + "#{@change.changes}"
        if params[:document][:file_upload].nil?
          @document = Document.find(params[:id])
          @document.update(document_code: params[:document][:document_code])
          @document.update(document_seq_no: params[:document][:document_seq_no])
          @document.update(document_date: params[:document][:document_date])
          @document.update(document_title: params[:document][:document_title])
          @document.update(document_type_id: params[:document][:document_type_id])
          @document.update(save_location: params[:document][:save_location])
          @document.update(save_date: params[:document][:save_date])
          @document.update(keterangan: params[:document][:keterangan])
          @document.update(penanggung_jawab: params[:document][:penanggung_jawab])
          @document.update(document_classification_id: params[:document][:document_classification_id])

          @document.update(revision: params[:document][:revision])
          @document.update(sifat: params[:document][:sifat])

          @document.update(sub_document_type_id: params[:document][:sub_document_type_id])
          @document.update(sub2_document_type_id: params[:document][:sub2_document_type_id])
          @document.update(document_reference_id: params[:document][:document_reference_id])
          # @document.update(revision: '0')
          # nama = Member.find_by(member_id: current_user.member_id)
          # @document.update(issued_by: "#{nama.nama}")
          @document.update(issued_by: params[:document][:issued_by])
          # if @document.status == "Request" || @document.status == "Open"
          #     if params[:document][:status] == "Request"
          #       @document.update(status: params[:document][:status])
          #       @document.update(reason: params[:document][:reason])
          #     else
          #       @document.update(status: params[:document][:status])
          #       @document.update(reason: '')
          #     end
          # else
          #   @document.update(status: "Revision Done")
          # end
        else
          @documents = Document.find(params[:id])
          if @documents.status == "Pending Revision"
            # folder_path = File.join('file','DMS')
            # file_path= File.join('public',folder_path,params[:nmfile])
            # File.delete(file_path) if File.exist?(file_path)

            folder_path = File.join('file', 'DMS', 'Quality_Management')

            if !Dir.exist? folder_path
              FileUtils::mkdir_p (Rails.root.join('public', folder_path))
            end

            if (!params[:document][:file_upload].nil?)
              uploaded_io = params[:document][:file_upload]
              file_extention = File.extname(uploaded_io.original_filename)
              rename = params[:document][:document_code].gsub('/', '-') + file_extention

              file_path = File.join(folder_path, Time.new.strftime("REVISION_QM%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
              file_name = File.join(Time.new.strftime("REVISION_QM%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
              # file_path= File.join(folder_path, Time.new.strftime("IMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ","_"))
              # file_name= File.join(Time.new.strftime("IMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ","_"))
              if file_extention.match(/(.pdf|.mp4|.docx|docs)/)
                File.open(Rails.root.join('public', file_path), 'wb') do |file|
                    file.write(uploaded_io.read)
                end
                  nama_file = file_name
              end
            end
          else
            folder_path = File.join('file', 'DMS', 'Quality_Management')
            file_path = File.join('public', folder_path, params[:nmfile])
            File.delete(file_path) if File.exist?(file_path)
          end

          @document = Document.find(params[:id])
          @document.update(document_code: params[:document][:document_code])
          @document.update(document_seq_no: params[:document][:document_seq_no])
          @document.update(document_date: params[:document][:document_date])
          @document.update(document_title: params[:document][:document_title])
          @document.update(document_type_id: params[:document][:document_type_id])
          @document.update(save_location: params[:document][:save_location])
          @document.update(save_date: params[:document][:save_date])
          @document.update(keterangan: params[:document][:keterangan])
          @document.update(penanggung_jawab: params[:document][:penanggung_jawab])
          @document.update(document_classification_id: params[:document][:document_classification_id])

          @document.update(revision: params[:document][:revision])
          @document.update(sifat: params[:document][:sifat])

          @document.update(sub_document_type_id: params[:document][:sub_document_type_id])
          @document.update(sub2_document_type_id: params[:document][:sub2_document_type_id])
          @document.update(document_reference_id: params[:document][:document_reference_id])
          @document.update(file_upload: setUploadFile(params[:document][:file_upload], params[:document][:document_code]))
          nama = Member.find_by(member_id: current_user.member_id)
          # @document.update(issued_by: "#{nama.nama}")
          @document.update(issued_by: params[:document][:issued_by])
          # if @document.status == "Request" || @document.status == "Open"
          #   if params[:document][:status] == "Request"
          #     @document.update(status: params[:document][:status])
          #     @document.update(reason: params[:document][:reason])
          #     @document.update(revision: '0')
          #   else
          #     @document.update(status: params[:document][:status])
          #     @document.update(reason: '')
          #     @document.update(revision: '0')
          #   end
          # else
          #   @document.update(status: 'Revision Done')
          # end
        end
        # create_user_activity params[:document][:document_code], current_user.nama + " has been editing document with title : " + params[:document][:document_title]
        # redirect_to documents_url, notice: 'Document was successfully updated.'
        # redirect_to view_all_index_documents_path, notice: 'Document was successfully updated.'
        # respond_to do |format|
        #   if @document.update(document_params)
        #     format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        #     format.json { render :show, status: :ok, location: @document }
        #   else
        #     format.html { render :edit }
        #     format.json { render json: @document.errors, status: :unprocessable_entity }
        #   end
        # end
        redirect_to view_all_index_documents_path, notice: 'Document was successfully updated.'
    else
      redirect_to home_qms_documents_path, notice: "Format not allowed"
    end
  end

  def restore
    Document.only_deleted.where("document_id = ?", params[:document_id]).first.recover
    # redirect_to view_all_index_documents_path, notice: "Document has been restored"
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, :notice => "Document has been restored") }
      format.json { head :no_content }
    end
  end

  def soft_delete
    Document.find(params[:document_id]).destroy
    redirect_back(fallback_location: root_path, :notice => "Document has been deleted")
  end

  # def hapus_forever
  #   @document = Document.all
  #   # login_activity current_user.nama + " has been deleted all document"
  #   folder_path = File.join('file', 'DMS', 'Quality_Management')
  #   file_path = File.join('public', folder_path)
  #   if File.exist?(file_path)
  #     # FileUtils.rm_rf(Dir.glob('public/File/DMS/Quality_Management'))
  #     FileUtils.rm_rf('public/file/DMS/Quality_Management')
  #   end
  #   @document.destroy_all
  #   @wr_doc = Document.with_deleted
  #   @wr_doc.destroy_all
  #
  #   respond_to do |format|
  #     format.html { redirect_to :back, notice: "Document has been deleted" }
  #     format.json { head :no_content }
  #   end
  # end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def hapus
    Document.only_deleted.where("document_id = ?", params[:document_id]).first.recover
    @document = Document.find(params[:document_id])
    create_user_activity @document.document_code, current_user.nama + " has been deleted document with title : " + @document.document_title
    nama_file = @document.file_upload
    nama_terkhir = Document.where(file_upload: nama_file).select('file_upload')
    if nama_terkhir.count > 1
      # @document.destroy
      @document.destroy_fully!
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, :notice => "Document has been deleted forever") }
        format.json { head :no_content }
      end
    else
      @nama = Document.find_by(file_upload: nama_file)
      file = @nama.file_upload
      folder_path = File.join('file', 'DMS', 'Quality_Management')
      file_path = File.join('public', folder_path, file)
      File.delete(file_path) if File.exist?(file_path)
      # @letter = Document.find(params[:id])
      # @document.destroy
      @document.destroy_fully!
      respond_to do |format|
        # format.html { redirect_to documents_url }
        format.html { redirect_back(fallback_location: root_path, :notice => "Document has been deleted forever") }
        format.json { head :no_content }
      end
    end
    # def destroy
    #   @document = Document.find(params[:id])
    #   create_user_activity @document.document_code, current_user.nama + " has been deleted document with title : " + @document.document_title
    #   nama_file = @document.file_upload
    #   nama_terkhir = Document.where(file_upload: nama_file).select('file_upload')
    #   if nama_terkhir.count > 1
    #     @document.destroy
    #     respond_to do |format|
    #       format.html { redirect_to documents_url }
    #       format.json { head :no_content }
    #     end
    #   else
    #     @nama = Document.find_by(file_upload: nama_file)
    #     file = @nama.file_upload
    #     folder_path = File.join('file', 'DMS', 'Quality_Management')
    #     file_path = File.join('public', folder_path, file)
    #     File.delete(file_path) if File.exist?(file_path)
    #     @letter = Document.find(params[:id])
    #     @document.destroy
    #     respond_to do |format|
    #       # format.html { redirect_to documents_url }
    #       format.html { redirect_to view_all_index_documents_path }
    #       format.json { head :no_content }
    #     end
    #   end
    # @document.destroy
    # respond_to do |format|
    #   format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  # def download
  #   @valid = DocumentRequest.where('requester = ? and request_date >= ?', current_user.nama, Date.current - 3.day).select('*').order('document_requests.id DESC')
  #   @incoming_letter = Document.find(params[:id])
  #   create_user_activity @incoming_letter.document_code, current_user.nama + " has been downloded document with title : " + @incoming_letter.document_title
  #   folder_path = File.join('file', 'DMS', 'Quality_Management')
  #   file_path = File.join(folder_path)
  #   if @incoming_letter.file_upload.nil? == false and @incoming_letter.file_upload.empty? == false and @valid.exists? == true
  #     send_file Rails.root.join('public', file_path, @incoming_letter.file_upload)
  #   else
  #     # head :no_content
  #     redirect_to document_requests_url
  #   end
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  def setUploadFile(file_upload, document_code)
    folder_path = File.join('file', 'DMS', 'Quality_Management')

    if !Dir.exist? folder_path
      FileUtils::mkdir_p (Rails.root.join('public', folder_path))
    end

    if (!file_upload.nil?)
      uploaded_io = file_upload
      file_extention = File.extname(uploaded_io.original_filename)
      rename = document_code.gsub('/', '-') + file_extention

      folder_path = File.join('file', 'DMS', 'Quality_Management')
      file_path = File.join(folder_path, Time.new.strftime("QM%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
      file_name = File.join(Time.new.strftime("QM%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
      if rename.match(/.pdf/) || rename.match(/.mp4/)
        File.open(Rails.root.join('public', file_path), 'wb') do |file|
          file.write(uploaded_io.read)
        end
        nama_file = file_name
      end
    end
    return nama_file
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.require(:document).permit(:document_code, :revision, :document_title, :issued_by, :file_upload, :status, :document_date, :reason, :save_location, :save_date, :keterangan, :sifat, :penanggung_jawab, :document_classification_id, :document_type_id, :sub_document_type_id, :document_reference_id, :sub2_document_type_id)
  end
end
