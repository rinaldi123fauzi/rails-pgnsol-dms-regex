class InternalWrAuditsController < ApplicationController
  before_action :set_internal_wr_audit, only: [:show, :edit, :update, :destroy]

  # GET /internal_wr_audits
  # GET /internal_wr_audits.json
  def index
    @internal_wr_audits = InternalWrAudit.all
  end

  # GET /internal_wr_audits/1
  # GET /internal_wr_audits/1.json
  def show
  end

  # GET /internal_wr_audits/new
  def new
    @internal_wr_audit = InternalWrAudit.new
  end

  # GET /internal_wr_audits/1/edit
  def edit
  end

  # POST /internal_wr_audits
  # POST /internal_wr_audits.json
  def create
    # @internal_wr_audit = InternalWrAudit.new(internal_wr_audit_params)
    #
    # respond_to do |format|
    #   if @internal_wr_audit.save
    #     format.html { redirect_to @internal_wr_audit, notice: 'Internal wr audit was successfully created.' }
    #     format.json { render :show, status: :created, location: @internal_wr_audit }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @internal_wr_audit.errors, status: :unprocessable_entity }
    #   end
    # end
    folder_path = File.join('file','DMS','Internal_Audit')

    if !Dir.exist? folder_path
      FileUtils::mkdir_p ( Rails.root.join('public',folder_path))
    end

    if(!params[:internal_wr_audit][:file_upload].nil?)
      uploaded_io = params[:internal_wr_audit][:file_upload]
      file_extention = File.extname(uploaded_io.original_filename)
      rename = params[:internal_wr_audit][:report_no].gsub('/','-') + file_extention

      file_path= File.join(folder_path,Time.new.strftime("AUDIT%Y%m_%H%M%S") + "_" + rename.gsub(" ","_"))
      file_name= File.join(Time.new.strftime("AUDIT%Y%m_%H%M%S") + "_" + rename.gsub(" ","_"))
      File.open( Rails.root.join('public',file_path), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      nama_file = file_name
    end
    @internal_wr_audit = InternalWrAudit.new
    @internal_wr_audit.report_no = params[:internal_wr_audit][:report_no]
    @internal_wr_audit.audit_date = params[:internal_wr_audit][:audit_date]
    user = Member.find(current_user.member_id)
    @internal_wr_audit.issued_by = "#{user.nama}"
    @internal_wr_audit.description = params[:internal_wr_audit][:description]
    @internal_wr_audit.file_upload = nama_file
    @internal_wr_audit.save
    redirect_to internal_wr_audits_url, notice: "Internal audit has been created"
  end

  # PATCH/PUT /internal_wr_audits/1
  # PATCH/PUT /internal_wr_audits/1.json
  def update
    # respond_to do |format|
    #   if @internal_wr_audit.update(internal_wr_audit_params)
    #     format.html { redirect_to @internal_wr_audit, notice: 'Internal wr audit was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @internal_wr_audit }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @internal_wr_audit.errors, status: :unprocessable_entity }
    #   end
    # end
    if params[:internal_wr_audit][:file_upload].nil?
      @internal_wr_audit = InternalWrAudit.find(params[:id])
      @internal_wr_audit.update(report_no: params[:internal_wr_audit][:report_no])
      @internal_wr_audit.update(audit_date: params[:internal_wr_audit][:audit_date])
      @internal_wr_audit.update(description: params[:internal_wr_audit][:description])
    else
      folder_path = File.join('file','DMS','Internal_Audit')
      file_path= File.join('public',folder_path,params[:nmfile])
      File.delete(file_path) if File.exist?(file_path)

      folder_path = File.join('file','DMS','Internal_Audit')

      if !Dir.exist? folder_path
        FileUtils::mkdir_p ( Rails.root.join('public',folder_path))
      end

      if(!params[:internal_wr_audit][:file_upload].nil?)
        uploaded_io = params[:internal_wr_audit][:file_upload]
        file_extention = File.extname(uploaded_io.original_filename)
        rename = params[:internal_wr_audit][:report_no].gsub('/','-') + file_extention

        file_path= File.join(folder_path,Time.new.strftime("AUDIT%Y%m_%H%M%S") + "_" + rename.gsub(" ","_"))
        file_name= File.join(Time.new.strftime("AUDIT%Y%m_%H%M%S") + "_" + rename.gsub(" ","_"))
        # file_path= File.join(folder_path, Time.new.strftime("IMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ","_"))
        # file_name= File.join(Time.new.strftime("IMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ","_"))
        File.open( Rails.root.join('public',file_path), 'wb') do |file|
          file.write(uploaded_io.read)
        end
        nama_file = file_name
      end
      @internal_wr_audit = InternalWrAudit.find(params[:id])
      @internal_wr_audit.update(report_no: params[:internal_wr_audit][:report_no])
      @internal_wr_audit.update(audit_date: params[:internal_wr_audit][:audit_date])
      @internal_wr_audit.update(description: params[:internal_wr_audit][:description])
      @internal_wr_audit.update(file_upload: nama_file)
    end
    redirect_to internal_wr_audits_url, notice: 'internal_audit was successfully updated.'
  end

  # DELETE /internal_wr_audits/1
  # DELETE /internal_wr_audits/1.json
  def destroy
    @internal_wr_audit.destroy
    respond_to do |format|
      format.html { redirect_to internal_wr_audits_url, notice: 'Internal wr audit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_wr_audit
      @internal_wr_audit = InternalWrAudit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def internal_wr_audit_params
      params.require(:internal_wr_audit).permit(:report_no, :audit_date, :issued_by, :description, :file_upload)
    end
end
