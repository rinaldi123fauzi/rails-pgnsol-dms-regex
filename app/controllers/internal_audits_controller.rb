class InternalAuditsController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  protect_from_forgery with: :exception
  before_action :set_internal_audit, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /internal_audits
  # GET /internal_audits.json'

  def closing_audit
    InternalAudit.update(params[:id], :status => "closed")
    redirect_to detail_audit_path(params[:id]), notice: 'This audit has closed.'
  end

  def dashboard

  end

  def index
    respond_to do |format|
      format.html
      # you can pass the view_context if you want to use helper methods\
      # @coba = "rinaldi.fauzi"
      # for parsing params from outside
      # format.json {render json: LogActivitiesDatatable.new(view_context, {coba: @coba})}
      #------------END---------------------
      format.json { render json: IndexInInternalAudits.new(view_context) }
    end
  end

  # GET /internal_audits/1
  # GET /internal_audits/1.json
  def show
  end

  # GET /internal_audits/new
  def new
    @internal_audit = InternalAudit.new
  end

  # GET /internal_audits/1/edit
  def edit
  end

  # POST /internal_audits
  # POST /internal_audits.json
  def create
    folder_path = File.join('file', 'DMS', 'Internal_Audit')

    if !Dir.exist? folder_path
      FileUtils::mkdir_p (Rails.root.join('public', folder_path))
    end
    uploaded_io = params[:internal_audit][:file_upload]
    file_extention = File.extname(uploaded_io.original_filename)
    unless params[:internal_audit][:report_no].match(/(<|>|alert|function()|dir)/) or 
      params[:internal_audit][:audit_date].match(/(<|>|alert|function()|dir)/) or
      params[:internal_audit][:description].match(/(<|>|alert|function()|dir)/) or
      params[:internal_audit][:fungsi_audit].match(/(<|>|alert|function()|dir)/) or
      params[:internal_audit][:division].match(/(<|>|alert|function()|dir)/)
      unless file_extention.match(/(.pdf|.docx|docs)/)
        if (!params[:internal_audit][:file_upload].nil?)
          uploaded_io = params[:internal_audit][:file_upload]
          file_extention = File.extname(uploaded_io.original_filename)
          rename = params[:internal_audit][:report_no].gsub('/', '-') + file_extention

          file_path = File.join(folder_path, Time.new.strftime("AUDIT%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
          file_name = File.join(Time.new.strftime("AUDIT%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
          File.open(Rails.root.join('public', file_path), 'wb') do |file|
            file.write(uploaded_io.read)
          end
          nama_file = file_name
        end
        @internal_audit = InternalAudit.new
        @internal_audit.report_no = params[:internal_audit][:report_no]
        @internal_audit.audit_date = params[:internal_audit][:audit_date]
        user = Member.find(current_user.member_id)
        @internal_audit.issued_by = "#{user.nama}"
        @internal_audit.description = params[:internal_audit][:description]
        @internal_audit.status = 'open'
        @internal_audit.fungsi_audit = params[:internal_audit][:fungsi_audit]
        @internal_audit.division = params[:internal_audit][:division]
        @internal_audit.file_upload = nama_file
        @internal_audit.save
        redirect_to internal_audits_url, notice: "Internal audit has been created"
      else
        redirect_to internal_audits_url, notice: "Format not allowed"
      end
    else
      redirect_to internal_audits_url, notice: "Format not allowed"
    end
    # respond_to do |format|
    #   if @internal_audit.save
    #     format.html { redirect_to @internal_audit, notice: 'Internal audit was successfully created.' }
    #     format.json { render :show, status: :created, location: @internal_audit }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @internal_audit.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /internal_audits/1
  # PATCH/PUT /internal_audits/1.json
  def update
    unless params[:internal_audit][:report_no].match(/(<|>|alert|function()|dir)/) or 
      params[:internal_audit][:audit_date].match(/(<|>|alert|function()|dir)/) or
      params[:internal_audit][:description].match(/(<|>|alert|function()|dir)/) or
      params[:internal_audit][:fungsi_audit].match(/(<|>|alert|function()|dir)/) or
      params[:internal_audit][:division].match(/(<|>|alert|function()|dir)/)
    
      if params[:internal_audit][:file_upload].nil?
        @internal_audit = InternalAudit.find(params[:id])
        @internal_audit.update(report_no: params[:internal_audit][:report_no])
        @internal_audit.update(audit_date: params[:internal_audit][:audit_date])
        @internal_audit.update(description: params[:internal_audit][:description])
        @internal_audit.update(fungsi_audit: params[:internal_audit][:fungsi_audit])
        @internal_audit.update(division: params[:internal_audit][:division])
        redirect_to internal_audits_url, notice: 'internal_audit was successfully updated.'
      else
        uploaded_io = params[:internal_audit][:file_upload]
        file_extention = File.extname(uploaded_io.original_filename)
        if file_extention.match(/(.pdf|.docx|docs)/)

          folder_path = File.join('file', 'DMS', 'Internal_Audit')
          file_path = File.join('public', folder_path, params[:nmfile])
          File.delete(file_path) if File.exist?(file_path)

          folder_path = File.join('file', 'DMS', 'Internal_Audit')

          if !Dir.exist? folder_path
            FileUtils::mkdir_p (Rails.root.join('public', folder_path))
          end

          if (!params[:internal_audit][:file_upload].nil?)
            uploaded_io = params[:internal_audit][:file_upload]
            file_extention = File.extname(uploaded_io.original_filename)
            rename = params[:internal_audit][:report_no].gsub('/', '-') + file_extention

            file_path = File.join(folder_path, Time.new.strftime("AUDIT%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
            file_name = File.join(Time.new.strftime("AUDIT%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
            # file_path= File.join(folder_path, Time.new.strftime("IMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ","_"))
            # file_name= File.join(Time.new.strftime("IMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ","_"))
            File.open(Rails.root.join('public', file_path), 'wb') do |file|
              file.write(uploaded_io.read)
            end
            nama_file = file_name
          end
          @internal_audit = InternalAudit.find(params[:id])
          @internal_audit.update(report_no: params[:internal_audit][:report_no])
          @internal_audit.update(audit_date: params[:internal_audit][:audit_date])
          @internal_audit.update(description: params[:internal_audit][:description])
          @internal_audit.update(fungsi_audit: params[:internal_audit][:fungsi_audit])
          @internal_audit.update(division: params[:internal_audit][:division])
          @internal_audit.update(file_upload: nama_file)
          redirect_to internal_audits_url, notice: 'internal_audit was successfully updated.'
        else
          redirect_to internal_audits_url, notice: "Format not allowed"
        end
      end
    else
      redirect_to internal_audits_url, notice: "Format not allowed"
    end
    # respond_to do |format|
    #   if @internal_audit.update(internal_audit_params)
    #     format.html { redirect_to @internal_audit, notice: 'Internal audit was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @internal_audit }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @internal_audit.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /internal_audits/1
  # DELETE /internal_audits/1.json
  def destroy
    @nama = InternalAudit.find(params[:id])
    file = @nama.file_upload
    folder_path = File.join('file', 'DMS', 'Internal_Audit')
    file_path = File.join('public', folder_path, file)
    File.delete(file_path) if File.exist?(file_path)

    @getTindakLanjut = FollowupAudit.where(internal_audit_id: params[:id]).select('*')

    unless @getTindakLanjut.empty?
      @getTindakLanjut.each do |f|
        file = f.file_upload
        folder_path = File.join('file', 'DMS', 'Internal_Audit', 'Audit_Tindak_Lanjut')
        file_path = File.join('public', folder_path, file)
        File.delete(file_path) if File.exist?(file_path)
      end
    end

    @internal_audit.destroy
    respond_to do |format|
      format.html { redirect_to internal_audits_url, notice: 'Internal audit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    @internal_audit = InternalAudit.find(params[:id])
    folder_path = File.join('file', 'DMS', 'Internal_Audit')
    file_path = File.join(folder_path)
    if @internal_audit.file_upload.nil? == false and @internal_audit.file_upload.empty? == false
      send_file Rails.root.join('public', file_path, @internal_audit.file_upload)
    else
      head :no_content
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_internal_audit
    @internal_audit = InternalAudit.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def internal_audit_params
    params.require(:internal_audit).permit(:report_no, :audit_date, :issued_by, :description, :file_upload, :status, :fungsi_audit, :division, :tindak_lanjut)
  end
end
