#Developer : Mohamad Rinaldi Fauzi
#DB table : wr_doc_types
#Module : WR (Work References)
#Sifat Tabel : Master
#Ket : Data type dokumen
class WrDocTypesController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  before_action :set_wr_doc_type, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /wr_doc_types
  # GET /wr_doc_types.json
  def index
    @wr_doc_types = WrDocType.all
  end

  # GET /wr_doc_types/1
  # GET /wr_doc_types/1.json
  def show
  end

  # GET /wr_doc_types/new
  def new
    @wr_doc_type = WrDocType.new
  end

  # GET /wr_doc_types/1/edit
  def edit
  end

  # POST /wr_doc_types
  # POST /wr_doc_types.json
  def create
    @wr_doc_type = WrDocType.new(wr_doc_type_params)

    respond_to do |format|
      if @wr_doc_type.save
        format.html { redirect_to wr_doc_types_url, notice: 'Document type was successfully created.' }
        format.json { render :show, status: :created, location: @wr_doc_type }
      else
        format.html { render :new }
        format.json { render json: @wr_doc_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wr_doc_types/1
  # PATCH/PUT /wr_doc_types/1.json
  def update
    respond_to do |format|
      if @wr_doc_type.update(wr_doc_type_params)
        format.html { redirect_to wr_doc_types_url, notice: 'Document type was successfully updated.' }
        format.json { render :show, status: :ok, location: @wr_doc_type }
      else
        format.html { render :edit }
        format.json { render json: @wr_doc_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wr_doc_types/1
  # DELETE /wr_doc_types/1.json
  def destroy
    @wr_doc_type.destroy
    respond_to do |format|
      format.html { redirect_to wr_doc_types_url, notice: 'Document type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wr_doc_type
      @wr_doc_type = WrDocType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wr_doc_type_params
      params.require(:wr_doc_type).permit(:document_name, :desc_document)
    end
end
