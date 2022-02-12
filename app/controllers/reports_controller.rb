class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @reports = Report.where(id: params[:id]).select('*')
    @reports.each do |f|
      @report_id = f.id
      @report_project_name = f.project_name
      @report_date = f.date
      @report_issued_by = f.issued_by
      @report_file_upload = f.file_upload
    end
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    folder_path = File.join('file','DMS')

    if !Dir.exist? folder_path
      FileUtils::mkdir_p ( Rails.root.join('public',folder_path))
    end

    if(!params[:report][:file_upload].nil?)
      uploaded_io = params[:report][:file_upload]
      file_extention = File.extname(uploaded_io.original_filename)
      rename = params[:report][:project_name].gsub('/','-') + file_extention

      file_path= File.join(folder_path,Time.new.strftime("REPORT%Y%m_%H%M%S") + "_" + rename.gsub(" ","_"))
      file_name= File.join(Time.new.strftime("REPORT%Y%m_%H%M%S") + "_" + rename.gsub(" ","_"))
      File.open( Rails.root.join('public',file_path), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      nama_file = file_name
    end

    @report = Report.new(report_params)
    @report.project_name = params[:report][:project_name]
    @report.issued_by = params[:report][:issued_by]
    @report.date = params[:report][:date]
    @report.file_upload = nama_file
    @report.save

    redirect_to reports_url, notice: 'Report was successfully created.'

    # respond_to do |format|
    #   if @report.save
    #     format.html { redirect_to @report, notice: 'Report was successfully created.' }
    #     format.json { render :show, status: :created, location: @report }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @report.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:project_name, :issued_by, :date, :file_upload)
    end
end
