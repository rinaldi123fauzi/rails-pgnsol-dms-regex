class DocumentReferencesController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  before_action :set_document_reference, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /document_references
  # GET /document_references.json
  def index
    @document_references = DocumentReference.all
  end

  # GET /document_references/1
  # GET /document_references/1.json
  def show
  end

  # GET /document_references/new
  def new
    @document_reference = DocumentReference.new
  end

  # GET /document_references/1/edit
  def edit
  end

  # POST /document_references
  # POST /document_references.json
  def create
    @document_reference = DocumentReference.new(document_reference_params)

    respond_to do |format|
      if @document_reference.save
        # format.html { redirect_to @document_reference, notice: 'Document reference was successfully created.' }
        format.html { redirect_to document_references_url, notice: 'Document reference was successfully created.' }
        format.json { render :show, status: :created, location: @document_reference }
      else
        format.html { render :new }
        format.json { render json: @document_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_references/1
  # PATCH/PUT /document_references/1.json
  def update
    respond_to do |format|
      if @document_reference.update(document_reference_params)
        # format.html { redirect_to @document_reference, notice: 'Document reference was successfully updated.' }
        format.html { redirect_to document_references_url, notice: 'Document reference was successfully updated.' }
        format.json { render :show, status: :ok, location: @document_reference }
      else
        format.html { render :edit }
        format.json { render json: @document_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_references/1
  # DELETE /document_references/1.json
  def destroy
    @document_reference.destroy
    respond_to do |format|
      format.html { redirect_to document_references_url, notice: 'Document reference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_reference
      @document_reference = DocumentReference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_reference_params
      params.require(:document_reference).permit(:reference_name)
    end
end
