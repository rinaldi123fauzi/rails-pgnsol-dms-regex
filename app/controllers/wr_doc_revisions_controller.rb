class WrDocRevisionsController < ApplicationController
  before_action :set_wr_doc_revision, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /wr_doc_revisions
  # GET /wr_doc_revisions.json
  def index
    @wr_doc_revisions = WrDocRevision.joins(:wr_doc).select('
      wr_docs.document_code, wr_doc_revisions.description, wr_doc_revisions.date, wr_doc_revisions.file_upload,
      wr_doc_revisions.status, wr_doc_revisions.wr_doc_revision_id
      ')
  end

  # GET /wr_doc_revisions/1
  # GET /wr_doc_revisions/1.json
  def show
    @wr_doc_revisions = WrDocRevision.joins(:wr_doc).where(wr_doc_revision_id: params[:id]).select('
      wr_doc_revisions.description, wr_doc_revisions.status, wr_doc_revisions.file_upload, wr_doc_revisions.date,
      wr_docs.document_code, wr_doc_revisions.wr_doc_id
      ')
    @wr_doc_revisions.each do |f|
      @wr_doc_id = f.wr_doc_id
      @wr_doc_code = f.document_code
      @wr_doc_rev_description = f.description
      @wr_doc_rev_file_upload = f.file_upload
      @wr_doc_rev_status = f.status
      @wr_doc_rev_date = f.date
    end
  end

  # GET /wr_doc_revisions/new
  def new
    @wr_doc_revision = WrDocRevision.new
  end

  def new_to_check
    @wr_doc_revision = WrDocRevision.new
  end

  # GET /wr_doc_revisions/1/edit
  def edit
  end

  # POST /wr_doc_revisions
  # POST /wr_doc_revisions.json
  def create
    # @wr_doc_revision = WrDocRevision.new(wr_doc_revision_params)

    # @document_revision = DocumentRevision.new
    @wr_doc_revision = WrDocRevision.new
    @doc_cek = WrDoc.find(params[:wr_doc_revision][:wr_doc_id])
    @wr_doc_revision.wr_doc_id = params[:wr_doc_revision][:wr_doc_id]
    @wr_doc_revision.description = params[:wr_doc_revision][:description]
    @wr_doc_revision.date = params[:wr_doc_revision][:date]
    @wr_doc_revision.file_upload = "#{@doc_cek.file_upload}"
    @wr_doc_revision.status = params[:wr_doc_revision][:status]
    @wr_doc_revision.date = Time.new.strftime('%Y-%m-%d')
    @wr_doc_revision.save

    @count = WrDocRevision.where(wr_doc_id: params[:wr_doc_revision][:wr_doc_id]).select('*')
    @document = WrDoc.find(params[:wr_doc_revision][:wr_doc_id])
    @document.update(description_revision: params[:wr_doc_revision][:description])
    nama = Member.find_by(member_id: current_user.member_id)
    @document.update(checked_by: "#{nama.nama}")
    @document.update(approve: params[:approve])
    @document.update(status: params[:wr_doc_revision][:status])
    if params[:wr_doc_revision][:status] != "Pending Approval2"
      @document.update(revision: "#{@count.count}")
    end
    redirect_to document_check_wr_docs_path, notice: 'Invitation revision was successfully to create.'

    # respond_to do |format|
    #   if @wr_doc_revision.save
    #     format.html { redirect_to @wr_doc_revision, notice: 'Wr doc revision was successfully created.' }
    #     format.json { render :show, status: :created, location: @wr_doc_revision }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @wr_doc_revision.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /wr_doc_revisions/1
  # PATCH/PUT /wr_doc_revisions/1.json
  def update
    respond_to do |format|
      if @wr_doc_revision.update(wr_doc_revision_params)
        format.html { redirect_to @wr_doc_revision, notice: 'Wr doc revision was successfully updated.' }
        format.json { render :show, status: :ok, location: @wr_doc_revision }
      else
        format.html { render :edit }
        format.json { render json: @wr_doc_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wr_doc_revisions/1
  # DELETE /wr_doc_revisions/1.json
  def destroy
    @wr_doc_revision.destroy
    respond_to do |format|
      format.html { redirect_to wr_doc_revisions_url, notice: 'Wr doc revision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wr_doc_revision
      @wr_doc_revision = WrDocRevision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wr_doc_revision_params
      params.require(:wr_doc_revision).permit(:wr_doc_id, :description, :date, :file_upload, :status)
    end
end
