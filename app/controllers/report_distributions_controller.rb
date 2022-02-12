class ReportDistributionsController < ApplicationController
  before_action :set_report_distribution, only: [:show, :edit, :update, :destroy]

  # GET /report_distributions
  # GET /report_distributions.json
  def index
    @report_distributions = ReportDistribution.joins(:report).select('*')
  end

  # GET /report_distributions/1
  # GET /report_distributions/1.json
  def show
  end

  # GET /report_distributions/new
  def new
    @report_distribution = ReportDistribution.new
  end

  def new_document_distribution
    @report_distribution = ReportDistribution.new
    @report = Report.find_by(report_id: params[:report_id])
  end

  # GET /report_distributions/1/edit
  def edit
  end

  # POST /report_distributions
  # POST /report_distributions.json
  def create
    # @report_distribution = ReportDistribution.new(report_distribution_params)

    @params = params[:report_distribution][:receiver]
    @params.each do |receiver|
      @report_distribution = ReportDistribution.new
      @report_distribution.report_id = params[:report_distribution][:report_id]
      # @report_distribution.internal_audit_id = params[:report_distribution][:internal_audit_id]
      @report_distribution.sender = params[:report_distribution][:sender]
      @report_distribution.receiver = "#{receiver}"
      @report_distribution.date = Time.new.strftime('%Y-%m-%d')
      @report_distribution.status = "Pending"
      @report_distribution.save

      @user = Member.find_by(nama: "#{receiver}")
      begin
      UserMailer.document_receiver_report(@user).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    end
    redirect_to report_distributions_url, notice: 'Distribution was successfully created.'

    # respond_to do |format|
    #   if @report_distribution.save
    #     format.html { redirect_to @report_distribution, notice: 'Report distribution was successfully created.' }
    #     format.json { render :show, status: :created, location: @report_distribution }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @report_distribution.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /report_distributions/1
  # PATCH/PUT /report_distributions/1.json
  def update
    respond_to do |format|
      if @report_distribution.update(report_distribution_params)
        format.html { redirect_to @report_distribution, notice: 'Report distribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @report_distribution }
      else
        format.html { render :edit }
        format.json { render json: @report_distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_distributions/1
  # DELETE /report_distributions/1.json
  def destroy
    @report_distribution.destroy
    respond_to do |format|
      format.html { redirect_to report_distributions_url, notice: 'Report distribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_distribution
      @report_distribution = ReportDistribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_distribution_params
      params.require(:report_distribution).permit(:report_id, :sender, :receiver, :date, :status)
    end
end
