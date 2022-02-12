class FollowupAuditsController < ApplicationController
  before_action :set_followup_audit, only: [:show, :edit, :update, :destroy]

  # GET /followup_audits
  # GET /followup_audits.json

  def download
    @internal_audit = FollowupAudit.find(params[:id])
    folder_path = File.join('file','DMS','Internal_Audit', 'Audit_Tindak_Lanjut')
    file_path= File.join(folder_path)
    if @internal_audit.file_upload.nil? == false and @internal_audit.file_upload.empty? == false
      send_file Rails.root.join('public',file_path,@internal_audit.file_upload)
    else
      head :no_content
    end
  end

  def index
    @followup_audits = FollowupAudit.all
  end

  # GET /followup_audits/1
  # GET /followup_audits/1.json
  def show
  end

  # GET /followup_audits/new
  def new
    @followup_audit = FollowupAudit.new
  end

  # GET /followup_audits/1/edit
  def edit
  end

  # POST /followup_audits
  # POST /followup_audits.json
  def create
    folder_path = File.join('file','DMS','Internal_Audit', 'Audit_Tindak_Lanjut')

    if !Dir.exist? folder_path
      FileUtils::mkdir_p ( Rails.root.join('public',folder_path))
    end

    if(!params[:followup_audit][:file_upload].nil?)
      uploaded_io = params[:followup_audit][:file_upload]
      file_extention = File.extname(uploaded_io.original_filename)
      rename = file_extention

      file_path= File.join(folder_path,Time.new.strftime("Audit_Tindak_Lanjut_%Y%m_%H%M%S") + "_" + rename.gsub(" ","_"))
      file_name= File.join(Time.new.strftime("Audit_Tindak_Lanjut_%Y%m_%H%M%S") + "_" + rename.gsub(" ","_"))
      File.open( Rails.root.join('public',file_path), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      nama_file = file_name
    end

    @followup_audit = FollowupAudit.new(followup_audit_params)

    respond_to do |format|
      @followup_audit.internal_audit_id = params[:audit_id]
      user = Member.find(current_user.member_id)
      @followup_audit.issued_by = "#{user.nama}"
      @followup_audit.file_upload = nama_file
      if @followup_audit.save
        InternalAudit.update(params[:audit_id], :tindak_lanjut => 1)
        format.html { redirect_to detail_audit_path(params[:audit_id]), notice: 'Followup audit was successfully created.' }
        format.json { render :show, status: :created, location: @followup_audit }
      else
        format.html { render :new }
        format.json { render json: @followup_audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /followup_audits/1
  # PATCH/PUT /followup_audits/1.json
  def update
    respond_to do |format|
      if @followup_audit.update(followup_audit_params)
        format.html { redirect_to @followup_audit, notice: 'Followup audit was successfully updated.' }
        format.json { render :show, status: :ok, location: @followup_audit }
      else
        format.html { render :edit }
        format.json { render json: @followup_audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followup_audits/1
  # DELETE /followup_audits/1.json
  def destroy
    @nama = FollowupAudit.find(params[:id])
    file = @nama.file_upload
    folder_path = File.join('file', 'DMS', 'Internal_Audit', 'Audit_Tindak_Lanjut')
    file_path = File.join('public', folder_path, file)
    File.delete(file_path) if File.exist?(file_path)

    @followup_audit.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: 'Followup audit was successfully destroyed.')}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_followup_audit
      @followup_audit = FollowupAudit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def followup_audit_params
      params.require(:followup_audit).permit(:internal_audit_id, :notes, :descriptions, :file_upload, :date, :issued_by)
    end
end
