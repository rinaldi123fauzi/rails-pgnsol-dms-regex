#Developer : Mohamad Rinaldi Fauzi
#DB table : sub_document_types
#Module : QMS
#Sifat Tabel : Transaksi
#Ket : Data sub type dokumen
class SubDocumentTypesController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  before_action :set_sub_document_type, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /sub_document_types
  # GET /sub_document_types.json
  def index
    @sub_document_types = SubDocumentType.joins(:document_type).select('*')
  end

  # GET /sub_document_types/1
  # GET /sub_document_types/1.json
  def show
  end

  # GET /sub_document_types/new
  def new
    @sub_document_type = SubDocumentType.new
  end

  # GET /sub_document_types/1/edit
  def edit
  end

  # POST /sub_document_types
  # POST /sub_document_types.json
  def create
    @sub_document_type = SubDocumentType.new(sub_document_type_params)

    respond_to do |format|
      if @sub_document_type.save
        # format.html { redirect_to @sub_document_type, notice: 'Sub document type was successfully created.' }
        format.html { redirect_to sub_document_types_url, notice: 'Sub document type was successfully created.' }
        format.json { render :show, status: :created, location: @sub_document_type }
      else
        format.html { render :new }
        format.json { render json: @sub_document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_document_types/1
  # PATCH/PUT /sub_document_types/1.json
  def update
    respond_to do |format|
      if @sub_document_type.update(sub_document_type_params)
        format.html { redirect_to @sub_document_type, notice: 'Sub document type was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_document_type }
      else
        format.html { render :edit }
        format.json { render json: @sub_document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_document_types/1
  # DELETE /sub_document_types/1.json
  def destroy
    @sub_document_type.destroy
    respond_to do |format|
      format.html { redirect_to sub_document_types_url, notice: 'Sub document type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_document_type
      @sub_document_type = SubDocumentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_document_type_params
      params.require(:sub_document_type).permit(:document_type_id, :sub_type_name, :sub_description)
    end
end
