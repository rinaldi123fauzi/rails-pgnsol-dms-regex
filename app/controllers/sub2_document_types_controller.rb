#Developer : Mohamad Rinaldi Fauzi
#DB table : sub2_document_types
#Module : QMS (Quality Management)
#Sifat Tabel : Transaksi
#Ket : Data sub - sub type dokumen
class Sub2DocumentTypesController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  before_action :set_sub2_document_type, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /sub2_document_types
  # GET /sub2_document_types.json
  def index
    @sub2_document_types = Sub2DocumentType.joins(:sub_document_type).select('*')
  end

  # GET /sub2_document_types/1
  # GET /sub2_document_types/1.json
  def show
  end

  # GET /sub2_document_types/new
  def new
    @sub2_document_type = Sub2DocumentType.new
  end

  # GET /sub2_document_types/1/edit
  def edit
  end

  # POST /sub2_document_types
  # POST /sub2_document_types.json
  def create
    @sub2_document_type = Sub2DocumentType.new(sub2_document_type_params)

    respond_to do |format|
      if @sub2_document_type.save
        format.html { redirect_to sub2_document_types_url, notice: 'Sub2 document type was successfully created.' }
        format.json { render :show, status: :created, location: @sub2_document_type }
      else
        format.html { render :new }
        format.json { render json: @sub2_document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub2_document_types/1
  # PATCH/PUT /sub2_document_types/1.json
  def update
    respond_to do |format|
      if @sub2_document_type.update(sub2_document_type_params)
        format.html { redirect_to sub2_document_types_url, notice: 'Sub2 document type was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub2_document_type }
      else
        format.html { render :edit }
        format.json { render json: @sub2_document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub2_document_types/1
  # DELETE /sub2_document_types/1.json
  def destroy
    @sub2_document_type.destroy
    respond_to do |format|
      format.html { redirect_to sub2_document_types_url, notice: 'Sub2 document type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub2_document_type
      @sub2_document_type = Sub2DocumentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub2_document_type_params
      params.require(:sub2_document_type).permit(:sub_document_type_id, :sub2_type_name)
    end
end
