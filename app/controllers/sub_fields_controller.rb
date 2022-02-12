class SubFieldsController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  protect_from_forgery :except => [:update, :destroy, :create]
  before_action :set_sub_field, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /sub_fields
  # GET /sub_fields.json
  def index
    @sub_fields = SubField.joins(:field).select('*')
  end

  # GET /sub_fields/1
  # GET /sub_fields/1.json
  def show
  end

  # GET /sub_fields/new
  def new
    @sub_field = SubField.new
  end

  # GET /sub_fields/1/edit
  def edit
  end

  # POST /sub_fields
  # POST /sub_fields.json
  def create
    @sub_field = SubField.new(sub_field_params)
    @akses = []
    @akses = params[:sub_field][:akses]
    @sub_field.akses = @akses

    respond_to do |format|
      if @sub_field.save
        # format.html { redirect_to @sub_field, notice: 'Sub field was successfully created.' }
        format.html { redirect_to sub_fields_url, notice: 'Sub field was successfully created.' }
        format.json { render :show, status: :created, location: @sub_field }
      else
        format.html { render :new }
        format.json { render json: @sub_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_fields/1
  # PATCH/PUT /sub_fields/1.json
  def update
    respond_to do |format|
      if @sub_field.update(sub_field_params)
        @setAkses = SubField.find(params[:id])
        @akses = []
        @akses = params[:sub_field][:akses]
        @setAkses.update(akses: @akses)

        format.html { redirect_to @sub_field, notice: 'Sub field was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_field }
      else
        format.html { render :edit }
        format.json { render json: @sub_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_fields/1
  # DELETE /sub_fields/1.json
  def destroy
    @sub_field.destroy
    respond_to do |format|
      format.html { redirect_to sub_fields_url, notice: 'Sub field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_field
      @sub_field = SubField.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_field_params
      params.require(:sub_field).permit(:field_id, :description_sub_field, :akses)
    end
end
