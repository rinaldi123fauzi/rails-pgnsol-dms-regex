class DakTemplatesController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  protect_from_forgery with: :exception
  before_action :set_dak_template, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json

  # GET /dak_templates
  # GET /dak_templates.json
  def download
    @internal_audit = DakTemplate.find(params[:id])
    folder_path = File.join('file', 'Template_DAK')
    file_path = File.join(folder_path)
    if @internal_audit.file_upload.nil? == false and @internal_audit.file_upload.empty? == false
      send_file Rails.root.join('public', file_path, @internal_audit.file_upload)
    else
      head :no_content
    end
  end

  def index
    @dak_templates = DakTemplate.all
  end

  # GET /dak_templates/1
  # GET /dak_templates/1.json
  def show
  end

  # GET /dak_templates/new
  def new
    @dak_template = DakTemplate.new
  end

  # GET /dak_templates/1/edit
  def edit
  end

  # POST /dak_templates
  # POST /dak_templates.json
  def create
    folder_path = File.join('file', 'Template_DAK')

    if !Dir.exist? folder_path
      FileUtils::mkdir_p (Rails.root.join('public', folder_path))
    end
    unless params[:dak_template][:description].match(/(<|>|alert|function()|dir)/) 
      if (!params[:dak_template][:file_upload].nil?)
        uploaded_io = params[:dak_template][:file_upload]
        file_extention = File.extname(uploaded_io.original_filename)
        rename = file_extention

        file_path = File.join(folder_path, Time.new.strftime("TemplateDAK_%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
        file_name = File.join(Time.new.strftime("TemplateDAK_%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
        if rename.match(/(.pdf|.docx|.docs|xlsx)/)
          File.open(Rails.root.join('public', file_path), 'wb') do |file|
            file.write(uploaded_io.read)
          end
          nama_file = file_name
        end
      end
      @issue_user = Member.find_by(member_id: current_user.member_id)
      @dak_template = DakTemplate.new(dak_template_params)

      unless rename.match(/(.pdf|.docx|.docs|xlsx)/)
        redirect_to dak_templates_url, notice: "Format not allowed"
      else
        respond_to do |format|
          @dak_template.file_upload = nama_file
          @dak_template.issued_by = @issue_user.nama
          if @dak_template.save
            format.html { redirect_to dak_templates_url, notice: 'Dak template was successfully created.' }
            format.json { render :show, status: :created, location: @dak_template }
          else
            format.html { render :new }
            format.json { render json: @dak_template.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      redirect_to dak_templates_url, notice: "Format not allowed"
    end
  end

  # PATCH/PUT /dak_templates/1
  # PATCH/PUT /dak_templates/1.json
  def update
    @cekFile = DakTemplate.find(params[:id])
    @issue_user = Member.find_by(member_id: current_user.member_id)
    unless params[:dak_template][:description].match(/(<|>|alert|function()|dir)/)
      if params[:dak_template][:file_upload].present?
        folder_path = File.join('file', 'Template_DAK')
        file_path = File.join('public', folder_path, @cekFile.file_upload)
        File.delete(file_path) if File.exist?(file_path)

        folder_path = File.join('file', 'Template_DAK')

        if !Dir.exist? folder_path
          FileUtils::mkdir_p (Rails.root.join('public', folder_path))
        end

        uploaded_io = params[:dak_template][:file_upload]
        file_extention = File.extname(uploaded_io.original_filename)
        rename = file_extention

        file_path = File.join(folder_path, Time.new.strftime("TemplateDAK_%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
        file_name = File.join(Time.new.strftime("TemplateDAK_%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
        if rename.match(/(.pdf|.docx|.docs|xlsx)/)
          File.open(Rails.root.join('public', file_path), 'wb') do |file|
            file.write(uploaded_io.read)
          end
          nama_file = file_name
          @update_file = DakTemplate.find(params[:id])
          @update_file.update(description: params[:dak_template][:description])
          @update_file.update(issued_by: @issue_user.nama)
          @update_file.update(file_upload: nama_file)
          redirect_to dak_templates_url, notice: 'Dak template was successfully updated.' 
        else
          redirect_to dak_templates_url, notice: 'Format not allowed.'
        end
      else
        @update_file = DakTemplate.find(params[:id])
        @update_file.update(description: params[:dak_template][:description])
        @update_file.update(issued_by: @issue_user.nama)
        redirect_to dak_templates_url, notice: 'Dak template was successfully updated.'
      end
    else
      redirect_to dak_templates_url, notice: 'Format not allowed.'
    end
    # respond_to do |format|
    #   if @dak_template.update(dak_template_params)
    #     format.html { redirect_to dak_templates_url, notice: 'Dak template was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @dak_template }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @dak_template.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /dak_templates/1
  # DELETE /dak_templates/1.json
  def destroy
    @nama = DakTemplate.find(params[:id])
    file = @nama.file_upload
    folder_path = File.join('file', 'Template_DAK')
    file_path = File.join('public', folder_path, file)
    File.delete(file_path) if File.exist?(file_path)

    @dak_template.destroy
    respond_to do |format|
      format.html { redirect_to dak_templates_url, notice: 'Dak template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dak_template
    @dak_template = DakTemplate.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def dak_template_params
    params.require(:dak_template).permit(:description, :file_upload, :issued_by)
  end
end
