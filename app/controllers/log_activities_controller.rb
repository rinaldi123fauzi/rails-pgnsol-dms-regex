class LogActivitiesController < ApplicationController
  before_action :logged_in_user, except: [ :create]
  before_action :set_log_activity, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /log_activities
  # GET /log_activities.json

  def export_all

  end

  def export_request

  end

  def export_login

  end

  def report_all
    Axlsx::Package.new do |my_axlsx_package|
      my_axlsx_package.workbook do |wb|
        styles = wb.styles
        header = styles.add_style :bg_color => "c5ccd6", :sz => 12, :b => true, :alignment => {:horizontal => :center}, :border => { :style => :thin, :color => "000000", :edges => [:top, :bottom, :left, :right] }
        row = styles.add_style :alignment => {:horizontal => :center}, :border => { :style => :thin, :color => "000000", :edges => [:top, :bottom, :left, :right] }
        row_description = styles.add_style :border => { :style => :thin, :color => "000000", :edges => [:top, :bottom, :left, :right] }
        sort_number = styles.add_style :alignment => {:horizontal => :center}
        @log_activities = LogActivity.left_outer_joins(:member).where('activity_date BETWEEN ? AND ?', "#{params[:start_date]}", "#{params[:end_date]}").select('*').order('log_activities.activity_date DESC')
    
        wb.add_worksheet(name: "Log Aktifitas") do |sheet|
          sheet.add_row ["No","Nama", "Username", "Email", "Tanggal", "Aksi"], style: [header, header, header, header, header, header]
          @log_activities.each_with_index do |log_activity,index|
            sheet.add_row [index+1, log_activity.nama, log_activity.username, log_activity.email, log_activity.activity_date.strftime('%d %b %Y'), log_activity.activity], style: [sort_number]
          end
        end
      end
      send_data my_axlsx_package.to_stream.read, :filename => "data_log_dms.xlsx"
    end

    # @log_request = LogActivity.left_outer_joins(:member).where('activity_date BETWEEN ? AND ?', "#{params[:start_date]}", "#{params[:end_date]}").select('*').order('log_activities.activity_date DESC')
    # # end
    # respond_to do |format|
    #   format.html { head :no_content }
    #   format.pdf do
    #     # render :orientation => 'Landscape',:encoding => "utf8", :layout => "pdf_layout", pdf: "assessment_pdf.pdf"
    #     render :orientation => 'Landscape', :encoding => "utf8", :layout => "pdf_layout", pdf: "reportAll_" + Time.now.strftime('%Y%m%d%H%I%S'), :footer => {:right => '[page] of [topage]', :font_size => 8}, margin: {bottom: 4,
    #                                                                                                                                                                                                                       left: 2,
    #                                                                                                                                                                                                                       right: 2}
    #     # render :orientation => 'Portrait',:encoding => "utf8", :layout => "pdf_layout", pdf: "reportQMS_" + Time.now.strftime('%Y%m%d%H%I%S') + ".pdf"
    #   end
    # end
  end

  def report_request
    @log_request = LogActivity.left_outer_joins(:member).where('activity_date BETWEEN ? AND ? and controller = ? and action = ? or activity_date BETWEEN ? AND ? and controller = ? and action = ?', "#{params[:start_date]}", "#{params[:end_date]}", "document_requests", "create", "#{params[:start_date]}", "#{params[:end_date]}", "wr_doc_requests", "create").select('*').order('log_activities.activity_date DESC')
    # end
    respond_to do |format|
      format.html { head :no_content }
      format.pdf do
        # render :orientation => 'Landscape',:encoding => "utf8", :layout => "pdf_layout", pdf: "assessment_pdf.pdf"
        render :orientation => 'Landscape', :encoding => "utf8", :layout => "pdf_layout", pdf: "reportLogin_" + Time.now.strftime('%Y%m%d%H%I%S'), :footer => {:right => '[page] of [topage]', :font_size => 8}, margin: {bottom: 4,
                                                                                                                                                                                                                          left: 2,
                                                                                                                                                                                                                          right: 2}
        # render :orientation => 'Portrait',:encoding => "utf8", :layout => "pdf_layout", pdf: "reportQMS_" + Time.now.strftime('%Y%m%d%H%I%S') + ".pdf"
      end
    end
  end

  def report_login
    @log_login = LogActivity.left_outer_joins(:member).where('controller = ? and action = ? and activity_date BETWEEN ? AND ?', "sessions","create", "#{params[:start_date]}", "#{params[:end_date]}").select('*').order('activity_date DESC')
    # end
    respond_to do |format|
      format.html { head :no_content }
      format.pdf do
        # render :orientation => 'Landscape',:encoding => "utf8", :layout => "pdf_layout", pdf: "assessment_pdf.pdf"
        render :orientation => 'Landscape', :encoding => "utf8", :layout => "pdf_layout", pdf: "reportLogin_" + Time.now.strftime('%Y%m%d%H%I%S'), :footer => {:right => '[page] of [topage]', :font_size => 8}, margin: {bottom: 4,
                                                                                                                                                                                                                          left: 2,
                                                                                                                                                                                                                          right: 2}
        # render :orientation => 'Portrait',:encoding => "utf8", :layout => "pdf_layout", pdf: "reportQMS_" + Time.now.strftime('%Y%m%d%H%I%S') + ".pdf"
      end
    end
  end

  def list_login
    respond_to do |format|
      format.html
      # you can pass the view_context if you want to use helper methods\
      # @coba = "rinaldi.fauzi"
      # for parsing params from outside
      # format.json {render json: LogActivitiesDatatable.new(view_context, {coba: @coba})}
      #------------END---------------------
      format.json {render json: ListLoginInLogActivities.new(view_context)}
    end
  end

  def list_request
    respond_to do |format|
      format.html
      # you can pass the view_context if you want to use helper methods\
      # @coba = "rinaldi.fauzi"
      # for parsing params from outside
      # format.json {render json: LogActivitiesDatatable.new(view_context, {coba: @coba})}
      #------------END---------------------
      format.json {render json: ListRequestLogActivities.new(view_context)}
    end
  end

  def index
    respond_to do |format|
      format.html
      # you can pass the view_context if you want to use helper methods\
      # @coba = "rinaldi.fauzi"
      # for parsing params from outside
      # format.json {render json: LogActivitiesDatatable.new(view_context, {coba: @coba})}
      #------------END---------------------
      format.json {render json: IndexInLogActivities.new(view_context)}
    end
  end

  # GET /log_activities/1
  # GET /log_activities/1.json
  def show
  end

  # GET /log_activities/new
  def new
    @log_activity = LogActivity.new
  end

  # GET /log_activities/1/edit
  def edit
  end

  # POST /log_activities
  # POST /log_activities.json
  def create
    @log_activity = LogActivity.new(log_activity_params)

    respond_to do |format|
      if @log_activity.save
        format.html { redirect_to @log_activity, notice: 'Log activity was successfully created.' }
        format.json { render :show, status: :created, location: @log_activity }
      else
        format.html { render :new }
        format.json { render json: @log_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /log_activities/1
  # PATCH/PUT /log_activities/1.json
  def update
    respond_to do |format|
      if @log_activity.update(log_activity_params)
        format.html { redirect_to @log_activity, notice: 'Log activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @log_activity }
      else
        format.html { render :edit }
        format.json { render json: @log_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /log_activities/1
  # DELETE /log_activities/1.json
  def destroy
    @log_activity.destroy
    respond_to do |format|
      format.html { redirect_to log_activities_url, notice: 'Log activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log_activity
      @log_activity = LogActivity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_activity_params
      params.require(:log_activity).permit(:member_id, :document_code, :activity_date, :activity, :controller, :action, :browser, :ip_address)
    end
end
