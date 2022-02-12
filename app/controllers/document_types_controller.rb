#Developer : Mohamad Rinaldi Fauzi
#DB table : document_types
#Module : QMS
#Sifat Tabel : Master
#Ket : Data master untuk tipe dokumen
class DocumentTypesController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  before_action :set_document_type, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /document_types
  # GET /document_types.json
  def index
    @document_types = DocumentType.all
  end

  # GET /document_types/1
  # GET /document_types/1.json
  def show
  end

  # GET /document_types/new
  def new
    @document_type = DocumentType.new
  end

  # GET /document_types/1/edit
  def edit
  end

  # POST /document_types
  # POST /document_types.json
  def create
    @document_type = DocumentType.new(document_type_params)

    respond_to do |format|
      if @document_type.save
        # format.html { redirect_to @document_type, notice: 'Document type was successfully created.' }
        format.html { redirect_to document_types_url, notice: 'Document type was successfully created.' }
        format.json { render :show, status: :created, location: @document_type }
      else
        format.html { render :new }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_types/1
  # PATCH/PUT /document_types/1.json
  def update
    respond_to do |format|
      if @document_type.update(document_type_params)
        format.html { redirect_to @document_type, notice: 'Document type was successfully updated.' }
        format.json { render :show, status: :ok, location: @document_type }
      else
        format.html { render :edit }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_types/1
  # DELETE /document_types/1.json
  def destroy
    @document_type.destroy
    respond_to do |format|
      format.html { redirect_to document_types_url, notice: 'Document type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_type
      @document_type = DocumentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_type_params
      params.require(:document_type).permit(:type_name, :description, :akses => []) #https://stackoverflow.com/questions/16549382/how-to-permit-an-array-with-strong-parameters
    end
end
