#Developer : Mohamad Rinaldi Fauzi
#DB table : document_classifications
#Module : QMS (Quality Management)
#Sifat Tabel : Master
#Ket : Data klasifikasi dokumen
class DocumentClassificationsController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  before_action :set_document_classification, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /document_classifications
  # GET /document_classifications.json
  def index
    @document_classifications = DocumentClassification.joins(:sub_document_type).select('*')
  end

  # GET /document_classifications/1
  # GET /document_classifications/1.json
  def show
  end

  # GET /document_classifications/new
  def new
    @document_classification = DocumentClassification.new
  end

  # GET /document_classifications/1/edit
  def edit
  end

  # POST /document_classifications
  # POST /document_classifications.json
  def create
    @document_classification = DocumentClassification.new(document_classification_params)

    respond_to do |format|
      if @document_classification.save
        # format.html { redirect_to @document_classification, notice: 'Document classification was successfully created.' }
        format.html { redirect_to document_classifications_url, notice: 'Document classification was successfully created.' }
        format.json { render :show, status: :created, location: @document_classification }
      else
        format.html { render :new }
        format.json { render json: @document_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_classifications/1
  # PATCH/PUT /document_classifications/1.json
  def update
    respond_to do |format|
      if @document_classification.update(document_classification_params)
        # format.html { redirect_to @document_classification, notice: 'Document classification was successfully updated.' }
        format.html { redirect_to document_classifications_url, notice: 'Document classification was successfully created.' }
        format.json { render :show, status: :ok, location: @document_classification }
      else
        format.html { render :edit }
        format.json { render json: @document_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_classifications/1
  # DELETE /document_classifications/1.json
  def destroy
    @document_classification.destroy
    respond_to do |format|
      format.html { redirect_to document_classifications_url, notice: 'Document classification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_classification
      @document_classification = DocumentClassification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_classification_params
      params.require(:document_classification).permit(:sub_document_type_id, :classification_name)
    end
end
