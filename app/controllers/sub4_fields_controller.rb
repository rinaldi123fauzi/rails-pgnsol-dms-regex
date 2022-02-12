#Developer : Mohamad Rinaldi Fauzi
#DB table : sub4_fields
#Module : WR (Work References)
#Sifat Tabel : Transaksi
#Ket : Data sub field
class Sub4FieldsController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  before_action :set_sub4_field, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /sub4_fields
  # GET /sub4_fields.json
  def index
    @sub4_fields = Sub4Field.left_outer_joins(:sub3_field).select('*')
  end

  # GET /sub4_fields/1
  # GET /sub4_fields/1.json
  def show
  end

  # GET /sub4_fields/new
  def new
    @sub4_field = Sub4Field.new
  end

  # GET /sub4_fields/1/edit
  def edit
  end

  # POST /sub4_fields
  # POST /sub4_fields.json
  def create
    @sub4_field = Sub4Field.new(sub4_field_params)
    @akses = []
    @akses = params[:sub4_field][:akses]
    @sub4_field.akses = @akses

    respond_to do |format|
      if @sub4_field.save
        format.html { redirect_to sub4_fields_url, notice: 'Sub4 field was successfully created.' }
        format.json { render :show, status: :created, location: @sub4_field }
      else
        format.html { render :new }
        format.json { render json: @sub4_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub4_fields/1
  # PATCH/PUT /sub4_fields/1.json
  def update
    respond_to do |format|
      if @sub4_field.update(sub4_field_params)
        @setAkses = Sub4Field.find(params[:id])
        @akses = []
        @akses = params[:sub4_field][:akses]
        @setAkses.update(akses: @akses)

        format.html { redirect_to sub4_fields_url, notice: 'Sub4 field was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub4_field }
      else
        format.html { render :edit }
        format.json { render json: @sub4_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub4_fields/1
  # DELETE /sub4_fields/1.json
  def destroy
    @sub4_field.destroy
    respond_to do |format|
      format.html { redirect_to sub4_fields_url, notice: 'Sub4 field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub4_field
      @sub4_field = Sub4Field.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub4_field_params
      params.require(:sub4_field).permit(:sub3_field_id, :sub4_name_field, :akses)
    end
end
