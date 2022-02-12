#Developer : Mohamad Rinaldi Fauzi
#DB table : wr_docs
#Module : WR (Work References)
#Sifat Tabel : Transaksi
#Ket : Data dokumen WR
class WrDocsController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  protect_from_forgery with: :exception
  before_action :set_wr_doc, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /wr_docs
  # GET /wr_docs.json
  def index_request
    # if current_user.is? 10
    #   @documents = WrDocDistribution.joins(:wr_doc).where('wr_docs.field_id = ? and wr_doc_distributions.receiver = ?', params[:field_id], current_user.nama).select('*').order('wr_docs.date DESC')
    #   # @field = Field.find(params[:field_id])
    #   @sub_field = SubField.joins(:field).where('sub_fields.field_id = ?', params[:field_id]).select('*')
    # else
    # @documents = WrDoc.joins(:sub_field,:field,:wr_doc_type).where('wr_docs.field_id = ?', params[:field_id]).select('*').order('wr_docs.date DESC')
    # # @field = Field.find(params[:field_id])
    # @sub_field = SubField.joins(:field).where('sub_fields.field_id = ?', params[:field_id]).select('*')
    if !params[:document_title].nil? and !params[:document_code].present? and !params[:document_date].present?
      @documents = WrDoc.joins(:sub_field, :field, :wr_doc_type).select('*').where('wr_docs.document_title LIKE ? or wr_docs.document_title LIKE ?', "%#{params[:document_title].titleize}%", "%#{params[:document_title].downcase}%").order('wr_docs.date DESC')
    elsif !params[:document_code].nil? and !params[:document_date].present? and !params[:document_title].present?
      @documents = WrDoc.joins(:sub_field, :field, :wr_doc_type).select('*').where('wr_docs.document_code LIKE ?', "%#{params[:document_code]}%").order('wr_docs.date DESC')
    elsif !params[:document_code].present? and !params[:document_date].nil? and !params[:document_title].present?
      @documents = WrDoc.joins(:sub_field, :field, :wr_doc_type).select('*').where('wr_docs.date = ?', "#{params[:document_date]}").order('wr_docs.date DESC')
    else
      @documents = WrDoc.joins(:sub_field, :field, :wr_doc_type).select('*').order('wr_docs.date DESC')
    end
    # end
  end

  def report
    @wr_docs = WrDoc.joins(:field).select('*').order("penanggung_jawab, description_field, document_code ASC, date ASC")
    respond_to do |format|
      format.html { head :no_content }
      format.pdf do
        # render :orientation => 'Landscape',:encoding => "utf8", :layout => "pdf_layout", pdf: "assessment_pdf.pdf"
        render :orientation => 'Landscape', :encoding => "utf8", :layout => "pdf_layout", pdf: "reportReferenceDoc_" + Time.now.strftime('%Y%m%d%H%I%S'), :footer => {:right => '[page] of [topage]', :font_size => 8}, margin: {# default 10 (mm)
                                                                                                                                                                                                                                 left: 4,
                                                                                                                                                                                                                                 right: 4}
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
          @wr_document = WrDoc.find(params[:wr_doc_id])
          create_user_activity @wr_document.document_code, current_user.nama + " has been viewing document with title : " + @wr_document.document_title
        end
      end
    end
    #code
  end

  def home_document
    if params[:description_field].present?
      @fields = Field.select('*').where('description_field LIKE ? or description_field LIKE ? or description_field LIKE ?', "%#{params[:description_field].upcase}%", "%#{params[:description_field].downcase}%", "%#{params[:description_field].titleize}%").order('description_field ASC')
    else
      @fields = Field.select('*').order('description_field ASC')
    end
    # @custom_paginate_renderer = custom_paginate_renderer
  end

  def sub_home_document
    @subfield = SubField.where(field_id: params[:field_id]).select('*').order('description_sub_field ASC')
    
    #try catch
    unless @subfield.present?
      render_404
    end
    # @custom_paginate_renderer = custom_paginate_renderer
  end

  def sub2_home_document
    @sub2_field = Sub2Field.where(sub_field_id: params[:sub_field_id]).select('*').order('sub2_name ASC')
    
    #try catch
    unless @sub2_field.present?
      render_404
    end
  end

  def sub3_home_document
    @sub3_field = Sub3Field.where(sub2_field_id: params[:sub2_field_id]).select('*').order('sub3_name_field ASC')

    #try catch
    unless @sub3_field.present?
      render_404
    end
  end

  def sub4_home_document

  end

  def document_request
    # if current_user.is? 10
    #   @documents = Distribution.joins(:document).where('distributions.receiver = ? and distributions.status = ?', current_user.nama, "Received").where.not('documents.reason = ?', "").select('*')
    # else
    #   @documents = Document.where.not(reason: "").select('*')
    # end
    if current_user.is? 10
      @documents = WrDoc.joins(:wr_doc_type).select('*')
    else
      @documents = WrDocRequest.joins(:wr_doc).select('*')
    end
  end

  def document_approval
    @documents = WrDoc.where(approve: current_user.nama).select('*')
  end

  def document_check
    # @documents = Document.joins(:wr_doc).where('status = ? or status = ?', 'Open', 'Request').select('*')
    @documents = WrDoc.where(checker: current_user.nama).select('*')
  end

  def document_distribution
    # @documents = Document.joins(:wr_doc).where('status = ? or status = ?', 'Open', 'Request').select('*')
    @documents = WrDoc.select('*')
  end

  def view_index
    @document_title = params[:document_title]
    @document_code = params[:document_code]
    @document_date = params[:document_date]
    @description = SubField.left_outer_joins(:field).where(sub_field_id: params[:sub_field_id]).select('*')

    #try catch
    unless @description.present?
      render_404
    end
    
    if @document_title.present?
      respond_to do |format|
        format.html
        @document = params[:document_title]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewIndexInWrDocs.new(view_context, {document: @document}) }
      end
    elsif @document_code.present?
      respond_to do |format|
        format.html
        @document = params[:document_code]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewIndexInWrDocs.new(view_context, {document: @document}) }
      end
    elsif @document_date.present?
      respond_to do |format|
        format.html
        @document = params[:document_date]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewIndexInWrDocs.new(view_context, {document: @document}) }
      end
    else
      respond_to do |format|
        format.html
        @document = nil
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewIndexInWrDocs.new(view_context, {document: @document}) }
      end
    end
  end

  def view2_index
    @document_title = params[:document_title]
    @document_code = params[:document_code]
    @document_date = params[:document_date]

    @description = Sub2Field.find_by(sub2_field_id: params[:sub2_field_id])

    #try catch
    unless @description.present?
      render_404
    end

    if @document_title.present?
      respond_to do |format|
        format.html
        @document = params[:document_title]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View2IndexInWrDocs.new(view_context, {document: @document}) }
      end
    elsif @document_code.present?
      respond_to do |format|
        format.html
        @document = params[:document_code]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View2IndexInWrDocs.new(view_context, {document: @document}) }
      end
    elsif @document_date.present?
      respond_to do |format|
        format.html
        @document = params[:document_date]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View2IndexInWrDocs.new(view_context, {document: @document}) }
      end
    else
      respond_to do |format|
        format.html
        @document = nil
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View2IndexInWrDocs.new(view_context, {document: @document}) }
      end
    end
  end

  def view3_index
    @document_title = params[:document_title]
    @document_code = params[:document_code]
    @document_date = params[:document_date]

    @description = Sub3Field.find_by(sub3_field_id: params[:sub3_field_id])

    #try catch
    unless @description.present?
      render_404
    end

    if @document_title.present?
      respond_to do |format|
        format.html
        @document = params[:document_title]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View3IndexInWrDocs.new(view_context, {document: @document}) }
      end
    elsif @document_code.present?
      respond_to do |format|
        format.html
        @document = params[:document_code]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View3IndexInWrDocs.new(view_context, {document: @document}) }
      end
    elsif @document_date.present?
      respond_to do |format|
        format.html
        @document = params[:document_date]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View3IndexInWrDocs.new(view_context, {document: @document}) }
      end
    else
      respond_to do |format|
        format.html
        @document = nil
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: View3IndexInWrDocs.new(view_context, {document: @document}) }
      end
    end
  end

  def view4_index
    if params[:document_title].present? and !params[:document_code].present? and !params[:document_date].present?
      @documents = WrDoc.left_outer_joins(:sub_field, :field, :wr_doc_type, :sub2_field, :sub3_field, :sub4_field).where('wr_docs.sub4_field_id = ? and wr_docs.document_title LIKE ? or wr_docs.sub4_field_id = ? and wr_docs.document_title LIKE ?', params[:sub4_field_id], "%#{params[:document_title].titleize}%", params[:sub4_field_id], "%#{params[:document_title].downcase}%").select('*').order('wr_docs.date DESC')
    elsif params[:document_code].present? and !params[:document_title].present? and !params[:document_date].present?
      @documents = WrDoc.left_outer_joins(:sub_field, :field, :wr_doc_type, :sub2_field, :sub3_field, :sub4_field).where('wr_docs.sub4_field_id = ? and wr_docs.document_code LIKE ?', params[:sub4_field_id], "%#{params[:document_code]}%").select('*').order('wr_docs.date DESC')
    elsif params[:document_date].present? and !params[:document_title].present? and !params[:document_code].present?
      @documents = WrDoc.left_outer_joins(:sub_field, :field, :wr_doc_type, :sub2_field, :sub3_field, :sub4_field).where('wr_docs.sub4_field_id = ? and wr_docs.date = ?', params[:sub4_field_id], "#{params[:document_date]}").select('*').order('wr_docs.date DESC')
    elsif !params[:sub_field].nil?
      @documents = WrDoc.left_outer_joins(:sub_field, :field, :wr_doc_type, :sub2_field, :sub3_field, :sub4_field).where('wr_docs.sub4_field_id = ?', params[:sub4_field_id]).select('*').order('wr_docs.date DESC')
    else
      @documents = WrDoc.left_outer_joins(:sub_field, :field, :wr_doc_type, :sub2_field, :sub3_field, :sub4_field).where('wr_docs.sub4_field_id = ?', params[:sub4_field_id]).select('*').order('wr_docs.date DESC')
    end
  end

  def recycle_bin
    # if current_user.is? 10
    #   @documents = WrDocDistribution.joins(:wr_doc).where('wr_docs.field_id = ? and wr_doc_distributions.receiver = ?', params[:field_id], current_user.nama).select('*').order('wr_docs.date DESC')
    #   # @field = Field.find(params[:field_id])
    #   @sub_field = SubField.joins(:field).where('sub_fields.field_id = ?', params[:field_id]).select('*')
    # else
    # @documents = WrDoc.joins(:sub_field,:field,:wr_doc_type).where('wr_docs.field_id = ?', params[:field_id]).select('*').order('wr_docs.date DESC')
    # # @field = Field.find(params[:field_id])
    # @sub_field = SubField.joins(:field).where('sub_fields.field_id = ?', params[:field_id]).select('*')
    if !params[:document_title].nil? and !params[:document_code].present? and !params[:document_date].present?
      @documents = WrDoc.only_deleted.joins(:sub_field, :field, :wr_doc_type).select('*').where('wr_docs.document_title LIKE ? or wr_docs.document_title LIKE ?', "%#{params[:document_title].titleize}%", "%#{params[:document_title].downcase}%").order('wr_docs.date DESC')
    elsif !params[:document_code].nil? and !params[:document_date].present? and !params[:document_title].present?
      @documents = WrDoc.only_deleted.joins(:sub_field, :field, :wr_doc_type).select('*').where('wr_docs.document_code LIKE ?', "%#{params[:document_code]}%").order('wr_docs.date DESC')
    elsif !params[:document_code].present? and !params[:document_date].nil? and !params[:document_title].present?
      @documents = WrDoc.only_deleted.joins(:sub_field, :field, :wr_doc_type).select('*').where('wr_docs.date = ?', "#{params[:document_date]}").order('wr_docs.date DESC')
    else
      @documents = WrDoc.only_deleted.joins(:sub_field, :field, :wr_doc_type).select('*').order('wr_docs.date DESC')
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
        format.json { render json: ViewAllIndexInWrDocs.new(view_context, {document: @document}) }
      end
    elsif @document_date.present?
      respond_to do |format|
        format.html
        @document = params[:document_date]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewAllIndexInWrDocs.new(view_context, {document: @document}) }
      end
    elsif @document_code.present?
      respond_to do |format|
        format.html
        @document = params[:document_code]
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewAllIndexInWrDocs.new(view_context, {document: @document}) }
      end
    else
      respond_to do |format|
        format.html
        @document = nil
        # you can pass the view_context if you want to use helper methods\
        # for parsing params from outside
        format.json { render json: ViewAllIndexInWrDocs.new(view_context, {document: @document}) }
      end
    end
  end

  def index
    # if !params[:document_title].nil? and !params[:document_code].present? and !params[:document_date].present?
    #   @wr_docs = WrDoc.joins(:field, :sub_field, :wr_doc_type).select('*').where('wr_docs.document_title LIKE ? or wr_docs.document_title LIKE ?', "%#{params[:document_title].titleize}%", "%#{params[:document_title].downcase}%").order('wr_docs.date DESC')
    # elsif !params[:document_code].nil? and !params[:document_title].present? and !params[:document_date].present?
    #   @wr_docs = WrDoc.joins(:field, :sub_field, :wr_doc_type).select('*').where('wr_docs.document_code LIKE ?', "%#{params[:document_code]}%").order('wr_docs.date DESC')
    # elsif !params[:document_date].nil? and !params[:document_title].present? and !params[:document_code].present?
    #   @wr_docs = WrDoc.joins(:field, :sub_field, :wr_doc_type).select('*').where('wr_docs.date = ?', "#{params[:document_date]}").order('wr_docs.date DESC')
    # else
    #   @wr_docs = WrDoc.joins(:field, :sub_field, :wr_doc_type).select('*').order('wr_docs.date DESC')
    # end
    begin
      render_404
    rescue => exception
      render_404
    end
  end

  def do_approval
    @wr_docs = WrDoc.find(params[:wr_doc_id])
    # abort @document.document_title.inspect
    nama = Member.find_by(member_id: current_user.member_id)
    @wr_docs.update(approved_by: "#{nama.nama}")
    @wr_docs.update(status: "Done")
    redirect_to document_approval_wr_docs_path, notice: 'Document was successfully to approve.'
  end

  # GET /wr_docs/1
  # GET /wr_docs/1.json
  def view_show
    @wr_docs = WrDoc.joins(:wr_doc_type, :field, :sub_field).where('wr_docs.wr_doc_id = ?', params[:wr_doc_id]).select('*')
    @wr_docs.each do |f|
      @wr_docs_id = f.wr_doc_id
      @wr_docs_code = f.document_code
      @wr_docs_revision = f.revision
      @wr_docs_title = f.document_title
      @wr_docs_issued_by = f.issued_by
      @wr_docs_checked_by = f.checked_by
      @wr_docs_approved_by = f.approved_by
      @wr_docs_file_upload = f.file_upload
      @wr_docs_status = f.status
      @wr_docs_date = f.date ? f.date.strftime('%d %b %Y') : ""
      @wr_docs_field = f.description_field
      @wr_docs_sub_field = f.description_sub_field
      @wr_docs_doc_type = f.document_name
      @penanggung_jawab = f.penanggung_jawab
      @save_date = f.save_date
      @save_location = f.save_location
      @sifat = f.sifat
    end
  end

  # GET /wr_docs/new
  def new
    @wr_doc = WrDoc.new
  end

  # GET /wr_docs/1/edit
  def edit
  end

  # POST /wr_docs
  # POST /wr_docs.json
  def create
    # @wr_doc = WrDoc.new(wr_doc_params)

    folder_path = File.join('file', 'DMS', 'Work_Reference')

    if !Dir.exist? folder_path
      FileUtils::mkdir_p (Rails.root.join('public', folder_path))
    end
    uploaded_io = params[:wr_doc][:file_upload]
    file_extention = File.extname(uploaded_io.original_filename)
    
    unless  params[:wr_doc][:document_code].match(/(<|>|alert|function()|dir)/) or 
            params[:wr_doc][:document_title].match(/(<|>|alert|function()|dir)/) or
            params[:wr_doc][:issued_by].match(/(<|>|alert|function()|dir)/) or
            params[:wr_doc][:save_location].match(/(<|>|alert|function()|dir)/) or
            params[:wr_doc][:keterangan].match(/(<|>|alert|function()|dir)/) or
            params[:wr_doc][:sifat].match(/(<|>|alert|function()|dir)/) or
            params[:wr_doc][:penanggung_jawab].match(/(<|>|alert|function()|dir)/)

      unless file_extention.match(/(.pdf|.docx|.docs)/)
        redirect_to home_document_wr_docs_path, notice: "Format not allowed"
      else
        if (!params[:wr_doc][:file_upload].nil?)
          uploaded_io = params[:wr_doc][:file_upload]
          file_extention = File.extname(uploaded_io.original_filename)
          rename = params[:wr_doc][:document_code].gsub('/', '-') + file_extention

          file_path = File.join(folder_path, Time.new.strftime("WR%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
          file_name = File.join(Time.new.strftime("WR%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
          File.open(Rails.root.join('public', file_path), 'wb') do |file|
            file.write(uploaded_io.read)
          end
          nama_file = file_name
        end

        respond_to do |format|
          @wr_doc.file_upload = nama_file
          nama = Member.find_by(member_id: current_user.member_id)
          @wr_doc.issued_by = "#{nama.nama}"
          if params[:wr_doc][:status] == "Request"
            @wr_doc.status = params[:document][:status]
            # @wr_doc.reason = params[:document][:reason]
          else
            @wr_doc.status = "Open"
          end
          @wr_doc.date = params[:wr_doc][:date]
          if @wr_doc.save
            create_user_activity params[:wr_doc][:document_code], current_user.nama + " has been inputing document with title : " + params[:wr_doc][:document_title]
            format.html { redirect_to view_all_index_wr_docs_url, notice: 'Document was successfully created.' }
            format.json { render :show, status: :created, location: @wr_doc }
          else
            format.html { render :new }
            format.json { render json: @wr_doc.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      redirect_to home_document_wr_docs_path, notice: "Format not allowed"
    end
    # redirect_to wr_docs_url, notice: 'Document was successfully created.'
    # redirect_to view_all_index_wr_docs_url, notice: 'Document was successfully created.'
  end

  # PATCH/PUT /wr_docs/1
  # PATCH/PUT /wr_docs/1.json
  def update
    unless  params[:wr_doc][:document_code].match(/(<|>|alert|function()|dir)/) or 
      params[:wr_doc][:document_title].match(/(<|>|alert|function()|dir)/) or
      params[:wr_doc][:issued_by].match(/(<|>|alert|function()|dir)/) or
      params[:wr_doc][:save_location].match(/(<|>|alert|function()|dir)/) or
      params[:wr_doc][:keterangan].match(/(<|>|alert|function()|dir)/) or
      params[:wr_doc][:sifat].match(/(<|>|alert|function()|dir)/) or
      params[:wr_doc][:penanggung_jawab].match(/(<|>|alert|function()|dir)/)
        @change = WrDoc.find(params[:id])
        @change.document_code = params[:wr_doc][:document_code]
        @change.date = params[:wr_doc][:date]
        @change.document_title = params[:wr_doc][:document_title]
        @change.field_id = params[:wr_doc][:field_id]
        @change.sub_field_id = params[:wr_doc][:sub_field_id]
        @change.sub2_field_id = params[:wr_doc][:sub2_field_id]
        @change.sub3_field_id = params[:wr_doc][:sub3_field_id]
        @change.sub4_field_id = params[:wr_doc][:sub4_field_id]
        @change.wr_doc_type_id = params[:wr_doc][:wr_doc_type_id]
        @change.save_date = params[:wr_doc][:save_date]
        @change.penanggung_jawab = params[:wr_doc][:penanggung_jawab]
        @change.sifat = params[:wr_doc][:sifat]
        @change.revision = params[:wr_doc][:revision]
        @change.save_location = params[:wr_doc][:save_location]
        @change.keterangan = params[:wr_doc][:keterangan]
        @change.issued_by = params[:wr_doc][:issued_by]
        create_user_activity params[:wr_doc][:document_code], current_user.nama + " has been editing document with title : " + params[:wr_doc][:document_title] + " Changed : " + "#{@change.changes}"
        if params[:wr_doc][:file_upload].nil?
          @wr_doc = WrDoc.find(params[:id])
          @wr_doc.update(document_code: params[:wr_doc][:document_code])
          @wr_doc.update(date: params[:wr_doc][:date])
          @wr_doc.update(document_title: params[:wr_doc][:document_title])
          @wr_doc.update(field_id: params[:wr_doc][:field_id])
          @wr_doc.update(sub_field_id: params[:wr_doc][:sub_field_id])
          @wr_doc.update(sub2_field_id: params[:wr_doc][:sub2_field_id])
          @wr_doc.update(sub3_field_id: params[:wr_doc][:sub3_field_id])
          @wr_doc.update(sub4_field_id: params[:wr_doc][:sub4_field_id])
          @wr_doc.update(wr_doc_type_id: params[:wr_doc][:wr_doc_type_id])
          @wr_doc.update(save_date: params[:wr_doc][:save_date])
          @wr_doc.update(penanggung_jawab: params[:wr_doc][:penanggung_jawab])

          @wr_doc.update(sifat: params[:wr_doc][:sifat])
          @wr_doc.update(revision: params[:wr_doc][:revision])

          @wr_doc.update(save_location: params[:wr_doc][:save_location])
          @wr_doc.update(keterangan: params[:wr_doc][:keterangan])
          # nama = Member.find_by(member_id: current_user.member_id)
          # @wr_doc.update(issued_by: "#{nama.nama}")
          @wr_doc.update(issued_by: params[:wr_doc][:issued_by])
          # if @wr_doc.status == "Open"
          #   @wr_doc.update(status: params[:wr_doc][:status])
          # else
          #   @wr_doc.update(status: "Revision Done")
          # end
        else
          @wr_docs = WrDoc.find(params[:id])
          if @wr_docs.status == "Pending Revision"
            # folder_path = File.join('file','DMS')
            # file_path= File.join('public',folder_path,params[:nmfile])
            # File.delete(file_path) if File.exist?(file_path)

            folder_path = File.join('file', 'DMS', 'Work_Reference')

            if !Dir.exist? folder_path
              FileUtils::mkdir_p (Rails.root.join('public', folder_path))
            end

            if (!params[:wr_doc][:file_upload].nil?)
              uploaded_io = params[:wr_doc][:file_upload]
              file_extention = File.extname(uploaded_io.original_filename)
              rename = params[:wr_doc][:document_code].gsub('/', '-') + file_extention

              file_path = File.join(folder_path, Time.new.strftime("REVISION_WR%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
              file_name = File.join(Time.new.strftime("REVISION_WR%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
              # file_path= File.join(folder_path, Time.new.strftime("IMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ","_"))
              # file_name= File.join(Time.new.strftime("IMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ","_"))
              File.open(Rails.root.join('public', file_path), 'wb') do |file|
                file.write(uploaded_io.read)
              end
              nama_file = file_name
            end
          else
            folder_path = File.join('file', 'DMS', 'Work_Reference')
            file_path = File.join('public', folder_path, params[:nmfile])
            File.delete(file_path) if File.exist?(file_path)

            folder_path = File.join('file', 'DMS', 'Work_Reference')

            if !Dir.exist? folder_path
              FileUtils::mkdir_p (Rails.root.join('public', folder_path))
            end

            if (!params[:wr_doc][:file_upload].nil?)
              uploaded_io = params[:wr_doc][:file_upload]
              file_extention = File.extname(uploaded_io.original_filename)
              rename = params[:wr_doc][:document_code].gsub('/', '-') + file_extention

              file_path = File.join(folder_path, Time.new.strftime("WR%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
              file_name = File.join(Time.new.strftime("WR%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
              # file_path= File.join(folder_path, Time.new.strftime("IMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ","_"))
              # file_name= File.join(Time.new.strftime("IMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ","_"))
              File.open(Rails.root.join('public', file_path), 'wb') do |file|
                file.write(uploaded_io.read)
              end
              nama_file = file_name
            end
          end

          @wr_doc = WrDoc.find(params[:id])
          @wr_doc.update(document_code: params[:wr_doc][:document_code])
          @wr_doc.update(date: params[:wr_doc][:date])
          @wr_doc.update(document_title: params[:wr_doc][:document_title])
          @wr_doc.update(file_upload: nama_file)
          @wr_doc.update(field_id: params[:wr_doc][:field_id])
          @wr_doc.update(sub_field_id: params[:wr_doc][:sub_field_id])
          @wr_doc.update(sub2_field_id: params[:wr_doc][:sub2_field_id])
          @wr_doc.update(sub3_field_id: params[:wr_doc][:sub3_field_id])
          @wr_doc.update(sub4_field_id: params[:wr_doc][:sub4_field_id])
          @wr_doc.update(wr_doc_type_id: params[:wr_doc][:wr_doc_type_id])
          @wr_doc.update(save_date: params[:wr_doc][:save_date])
          @wr_doc.update(penanggung_jawab: params[:wr_doc][:penanggung_jawab])
          @wr_doc.update(issued_by: params[:wr_doc][:issued_by])

          @wr_doc.update(sifat: params[:wr_doc][:sifat])
          @wr_doc.update(revision: params[:wr_doc][:revision])

          @wr_doc.update(save_location: params[:wr_doc][:save_location])
          @wr_doc.update(keterangan: params[:wr_doc][:keterangan])
          # nama = Member.find_by(member_id: current_user.member_id)
          # @wr_doc.update(issued_by: "#{nama.nama}")
          # if @wr_doc.status == "Open"
          #     @wr_doc.update(status: params[:wr_doc][:status])
          # else
          #   @wr_doc.update(status: 'Revision Done')
          # end
        end
        # create_user_activity params[:wr_doc][:document_code], current_user.nama + " has been editing document with title : " + params[:wr_doc][:document_title]
        # respond_to do |format|
        #   if @wr_doc.update(wr_doc_params)
        #     format.html { redirect_to @wr_doc, notice: 'Wr doc was successfully updated.' }
        #     format.json { render :show, status: :ok, location: @wr_doc }
        #   else
        #     format.html { render :edit }
        #     format.json { render json: @wr_doc.errors, status: :unprocessable_entity }
        #   end
        # end
        redirect_to view_all_index_wr_docs_url, notice: 'Document was successfully updated.'
    else
      redirect_to home_document_wr_docs_path, notice: "Format not allowed"
    end
  end

  # def download
  #   @valid = WrDocRequest.where('requester = ? and request_date >= ?', current_user.nama, Date.current - 3.day).select('*').order('wr_doc_requests.id DESC')
  #   @incoming_letter = WrDoc.find(params[:id])
  #   create_user_activity @incoming_letter.document_code, current_user.nama + " has been downloaded document with title : " + @incoming_letter.document_title
  #   folder_path = File.join('file', 'DMS', 'Work_Reference')
  #   file_path = File.join(folder_path)
  #   if @incoming_letter.file_upload.nil? == false and @incoming_letter.file_upload.empty? == false and @valid.exists? == true
  #     send_file Rails.root.join('public', file_path, @incoming_letter.file_upload)
  #   else
  #     # head :no_content
  #     redirect_to wr_doc_requests_url
  #   end
  # end

  def restore
    WrDoc.only_deleted.where("wr_doc_id = ?", params[:wr_doc_id]).first.recover
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, :notice => "Document has been restored") }
      format.json { head :no_content }
    end
  end

  def soft_delete
    @wr_doc = WrDoc.find(params[:wr_doc_id]).destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, :notice => "Document has been deleted to recycle bin") }
      format.json { head :no_content }
    end
  end

  # DELETE /wr_docs/1
  # DELETE /wr_docs/1.json
  def hapus
    # @wr_doc.destroy
    # respond_to do |format|
    #   format.html { redirect_to wr_docs_url, notice: 'Wr doc was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    WrDoc.only_deleted.where("wr_doc_id = ?", params[:wr_doc_id]).first.recover
    @document = WrDoc.find(params[:wr_doc_id])
    create_user_activity @document.document_code, current_user.nama + " has been deleted document with title : " + @document.document_title
    nama_file = @document.file_upload
    nama_terkhir = WrDoc.where(file_upload: nama_file).select('file_upload')
    if nama_terkhir.count > 1
      # @document.destroy
      @document.destroy_fully!
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, :notice => "Document has been deleted forever") }
        format.json { head :no_content }
      end
    else
      @nama = WrDoc.find_by(file_upload: nama_file)
      file = @nama.file_upload
      folder_path = File.join('file', 'DMS', 'Work_Reference')
      file_path = File.join('public', folder_path, file)
      File.delete(file_path) if File.exist?(file_path)
      # @letter = WrDoc.find(params[:id])
      # @document.destroy
      @document.destroy_fully!
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, :notice => "Document has been deleted forever") }
        format.json { head :no_content }
      end
    end
  end

  # def hapus_selamanya
  #   @document = WrDoc.with_deleted
  #   # login_activity current_user.nama + " has been deleted all document"
  #   folder_path = File.join('file', 'DMS', 'Work_Reference')
  #   file_path = File.join('public', folder_path)
  #   if File.exist?(file_path)
  #     FileUtils.rm_rf(Dir.glob('public/file/DMS/Work_Reference'))
  #   end
  #   @document.destroy_all
  #   respond_to do |format|
  #     format.html { redirect_to :back, notice: "Document has been deleted" }
  #     format.json { head :no_content }
  #   end
  # end

  # def hapus_forever
  #   @document = WrDoc.all
  #   # login_activity current_user.nama + " has been deleted all document"
  #   folder_path = File.join('file', 'DMS', 'Work_Reference')
  #   file_path = File.join('public', folder_path)
  #   if File.exist?(file_path)
  #     # FileUtils.rm_rf(Dir.glob('public/File/DMS/Work_Reference'))
  #     FileUtils.rm_rf('public/file/DMS/Work_Reference')
  #   end
  #   @document.destroy_all
  #   @wr_doc = WrDoc.with_deleted
  #   @wr_doc.destroy_all
  #
  #   respond_to do |format|
  #     format.html { redirect_to :back, notice: "Document has been deleted" }
  #     format.json { head :no_content }
  #   end
  # end

  # def destroy
  #   # @wr_doc.destroy
  #   # respond_to do |format|
  #   #   format.html { redirect_to wr_docs_url, notice: 'Wr doc was successfully destroyed.' }
  #   #   format.json { head :no_content }
  #   # end
  #   @document = WrDoc.find(params[:id])
  #   create_user_activity @document.document_code, current_user.nama + " has been deleted document with title : " + @document.document_title
  #   nama_file = @document.file_upload
  #   nama_terkhir = WrDoc.where(file_upload: nama_file).select('file_upload')
  #   if nama_terkhir.count > 1
  #     @document.destroy
  #     respond_to do |format|
  #       format.html { redirect_to documents_url }
  #       format.json { head :no_content }
  #     end
  #   else
  #     @nama = WrDoc.find_by(file_upload: nama_file)
  #     file = @nama.file_upload
  #     folder_path = File.join('file', 'DMS', 'Work_Reference')
  #     file_path = File.join('public', folder_path, file)
  #     File.delete(file_path) if File.exist?(file_path)
  #     @letter = WrDoc.find(params[:id])
  #     @document.destroy
  #     respond_to do |format|
  #       format.html { redirect_to view_all_index_wr_docs_url }
  #       format.json { head :no_content }
  #     end
  #   end
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_wr_doc
    @wr_doc = WrDoc.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def wr_doc_params
    params.require(:wr_doc).permit(:document_code, :document_title, :field_id, :sub_field_id, :sub2_field_id, :sub3_field_id, :sub4_field_id, :wr_doc_type_id, :issued_by, :checked_by, :approved_by, :date, :file_upload, :revision, :status, :description_revision, :document_type_id, :save_location, :save_date, :sifat, :penanggung_jawab)
  end

end
