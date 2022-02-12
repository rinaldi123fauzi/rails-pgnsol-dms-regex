#Developer : Mohamad Rinaldi Fauzi
#DB table : document_revisions
#Module : QMS
#Sifat Tabel : Transaksi
#Ket : Data dokumen yang direvisi pada modules QMS
class DocumentRevisionsController < ApplicationController
  before_action :set_document_revision, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /document_revisions
  # GET /document_revisions.json
  def index
    @document_revisions = DocumentRevision.joins(:document).select('
      documents.document_code, documents.document_title, documents.issued_by, documents.checked_by,
      document_revisions.description, document_revisions.date, document_revisions.file_upload, document_revisions.status,
      document_revisions.id
      ')
  end

  # GET /document_revisions/1
  # GET /document_revisions/1.json
  def show
    @documents = DocumentRevision.joins(:document).where(id: params[:id]).select('
      documents.document_code, document_revisions.description, document_revisions.date,
      document_revisions.status, document_revisions.file_upload, document_revisions.document_id
      ')
    @documents.each do |f|
      @document_id = f.document_id
      @document_code = f.document_code
      @document_description = f.description
      @document_date = f.date
      @document_status = f.status
      @document_file_upload = f.file_upload
    end
  end

  # GET /document_revisions/new
  def new
    @document_revision = DocumentRevision.new
  end

  def new_to_check
    @document_revision = DocumentRevision.new
  end

  # GET /document_revisions/1/edit
  def edit
  end

  # POST /document_revisions
  # POST /document_revisions.json
  def create
    # @document_revision = DocumentRevision.new(document_revision_params)
    @document_revision = DocumentRevision.new
    @doc_cek = Document.find(params[:document_revision][:document_id])
    @document_revision.document_id = params[:document_revision][:document_id]
    @document_revision.description = params[:document_revision][:description]
    @document_revision.date = params[:document_revision][:date]
    if @doc_cek.status == "Open"
      @document_revision.status = "Original"
    end
    @document_revision.file_upload = "#{@doc_cek.file_upload}"
    @document_revision.status = params[:document_revision][:status]
    @document_revision.save

    @count = DocumentRevision.where(document_id: params[:document_revision][:document_id]).select('*')
    @document = Document.find(params[:document_revision][:document_id])
    @document.update(description_revision: params[:document_revision][:description])
    nama = Member.find_by(member_id: current_user.member_id)
    @document.update(checked_by: "#{nama.nama}")
    @document.update(approve: params[:approve])
    @document.update(status: params[:document_revision][:status])
    if params[:document_revision][:status] != "Pending Approval2"
      @document.update(revision: "#{@count.count}")
    end
    redirect_to document_check_documents_path, notice: 'Invitation revision was successfully to create.'
    # respond_to do |format|
    #   if @document_revision.save
    #     format.html { redirect_to @document_revision, notice: 'Document revision was successfully created.' }
    #     format.json { render :show, status: :created, location: @document_revision }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @document_revision.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /document_revisions/1
  # PATCH/PUT /document_revisions/1.json
  def update
    respond_to do |format|
      if @document_revision.update(document_revision_params)
        format.html { redirect_to @document_revision, notice: 'Document revision was successfully updated.' }
        format.json { render :show, status: :ok, location: @document_revision }
      else
        format.html { render :edit }
        format.json { render json: @document_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_revisions/1
  # DELETE /document_revisions/1.json
  def destroy
    @document_revision.destroy
    respond_to do |format|
      format.html { redirect_to document_revisions_url, notice: 'Document revision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_revision
      @document_revision = DocumentRevision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_revision_params
      params.require(:document_revision).permit(:document_id, :description, :date)
    end
end
