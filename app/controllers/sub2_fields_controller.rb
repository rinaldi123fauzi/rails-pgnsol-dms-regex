#Developer : Mohamad Rinaldi Fauzi
#DB table : sub2_fields
#Module : WR (Work References)
#Sifat Tabel : Transaksi
#Ket : Data sub field
class Sub2FieldsController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  before_action :set_sub2_field, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /sub2_fields
  # GET /sub2_fields.json
  def index
    @sub2_fields = Sub2Field.left_outer_joins(:sub_field).select('*')
  end

  # GET /sub2_fields/1
  # GET /sub2_fields/1.json
  def show
  end

  # GET /sub2_fields/new
  def new
    @sub2_field = Sub2Field.new
  end

  # GET /sub2_fields/1/edit
  def edit
  end

  # POST /sub2_fields
  # POST /sub2_fields.json
  def create
    @sub2_field = Sub2Field.new(sub2_field_params)
    @akses = []
    @akses = params[:sub2_field][:akses]
    @sub2_field.akses = @akses

    respond_to do |format|
      if @sub2_field.save
        format.html { redirect_to sub2_fields_url, notice: 'Sub2 field was successfully created.' }
        format.json { render :show, status: :created, location: @sub2_field }
      else
        format.html { render :new }
        format.json { render json: @sub2_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub2_fields/1
  # PATCH/PUT /sub2_fields/1.json
  def update
    respond_to do |format|
      if @sub2_field.update(sub2_field_params)
        @setAkses = Sub2Field.find(params[:id])
        @akses = []
        @akses = params[:sub2_field][:akses]
        @setAkses.update(akses: @akses)

        format.html { redirect_to sub2_fields_url, notice: 'Sub2 field was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub2_field }
      else
        format.html { render :edit }
        format.json { render json: @sub2_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub2_fields/1
  # DELETE /sub2_fields/1.json
  def destroy
    @sub2_field.destroy
    respond_to do |format|
      format.html { redirect_to sub2_fields_url, notice: 'Sub2 field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub2_field
      @sub2_field = Sub2Field.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub2_field_params
      params.require(:sub2_field).permit(:sub_field_id, :sub2_name, :akses)
    end
end
