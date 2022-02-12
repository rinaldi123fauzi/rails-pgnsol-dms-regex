#Developer : Mohamad Rinaldi Fauzi
#DB table : sub3_fields
#Module : WR (Work References)
#Sifat Tabel : Transaksi
#Ket : Data sub field
class Sub3FieldsController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  before_action :set_sub3_field, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /sub3_fields
  # GET /sub3_fields.json
  def index
    @sub3_fields = Sub3Field.joins(:sub2_field).select('*')
  end

  # GET /sub3_fields/1
  # GET /sub3_fields/1.json
  def show
  end

  # GET /sub3_fields/new
  def new
    @sub3_field = Sub3Field.new
  end

  # GET /sub3_fields/1/edit
  def edit
  end

  # POST /sub3_fields
  # POST /sub3_fields.json
  def create
    @sub3_field = Sub3Field.new(sub3_field_params)
    @akses = []
    @akses = params[:sub3_field][:akses]
    @sub3_field.akses = @akses

    respond_to do |format|
      if @sub3_field.save
        format.html { redirect_to sub3_fields_url, notice: 'Sub3 field was successfully created.' }
        format.json { render :show, status: :created, location: @sub3_field }
      else
        format.html { render :new }
        format.json { render json: @sub3_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub3_fields/1
  # PATCH/PUT /sub3_fields/1.json
  def update
    respond_to do |format|
      if @sub3_field.update(sub3_field_params)
        @setAkses = Sub3Field.find(params[:id])
        @akses = []
        @akses = params[:sub3_field][:akses]
        @setAkses.update(akses: @akses)

        format.html { redirect_to sub3_fields_url, notice: 'Sub3 field was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub3_field }
      else
        format.html { render :edit }
        format.json { render json: @sub3_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub3_fields/1
  # DELETE /sub3_fields/1.json
  def destroy
    @sub3_field.destroy
    respond_to do |format|
      format.html { redirect_to sub3_fields_url, notice: 'Sub3 field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub3_field
      @sub3_field = Sub3Field.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub3_field_params
      params.require(:sub3_field).permit(:sub2_field_id, :sub3_name_field, :akses)
    end
end
