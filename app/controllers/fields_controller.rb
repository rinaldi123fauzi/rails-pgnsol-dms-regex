#Developer : Mohamad Rinaldi Fauzi
#DB table : fields
#Module : WR (Work References)
#Sifat Tabel : Master
#Ket : Data master field
class FieldsController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  protect_from_forgery :except => [:update, :destroy, :create]
  before_action :set_field, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /fields
  # GET /fields.json
  def index
    @fields = Field.all
  end

  # GET /fields/1
  # GET /fields/1.json
  def show
  end

  # GET /fields/new
  def new
    @field = Field.new
  end

  # GET /fields/1/edit
  def edit
  end

  # POST /fields
  # POST /fields.json
  def create
    @field = Field.new(field_params)
    @akses = []
    @akses = params[:field][:akses]
    @field.akses = @akses

    respond_to do |format|
      if @field.save
        # format.html { redirect_to @field, notice: 'Field was successfully created.' }
        format.html { redirect_to fields_url, notice: 'Field was successfully created.' }
        format.json { render :show, status: :created, location: @field }
      else
        format.html { render :new }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fields/1
  # PATCH/PUT /fields/1.json
  def update
    respond_to do |format|
      if @field.update(field_params)
        @setAkses = Field.find(params[:id])
        @akses = []
        @akses = params[:field][:akses]
        @setAkses.update(akses: @akses)

        format.html { redirect_to @field, notice: 'Field was successfully updated.' }
        format.json { render :show, status: :ok, location: @field }
      else
        format.html { render :edit }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fields/1
  # DELETE /fields/1.json
  def destroy
    @field.destroy
    respond_to do |format|
      format.html { redirect_to fields_url, notice: 'Wr doc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_field
      @field = Field.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def field_params
      params.require(:field).permit(:description_field, :akses)
    end
end
