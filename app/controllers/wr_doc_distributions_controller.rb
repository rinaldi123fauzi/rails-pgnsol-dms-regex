class WrDocDistributionsController < ApplicationController
  before_action :set_wr_doc_distribution, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource
  # respond_to :html, :json

  # GET /wr_doc_distributions
  # GET /wr_doc_distributions.json

  def new_distribution
    @wr_doc_distribution = WrDocDistribution.new
    @wr_doc_request = WrDocRequest.find_by_id(params[:id])
  end

  def receive
    @distribution = WrDocDistribution.find(params[:id])
    @distribution.update(status: "Received")
    redirect_to wr_doc_distributions_url, notice: 'Status Received'
  end

  def download_document
    @distribution = WrDocDistribution.find_by_id(params[:id])
    if @distribution.present?
      send_file Rails.root.join('public', @distribution.attachment_file)
    else
      head :no_content
    end
  end

  def index
    @wr_doc_distributions = WrDocDistribution.left_outer_joins(:wr_doc).where(receiver: current_user.username).select('
      wr_docs.document_code, wr_docs.document_title, wr_docs.field_id, wr_docs.sub_field_id, wr_doc_distributions.sender, wr_doc_distributions.receiver,
      wr_doc_distributions.date, wr_doc_distributions.status, wr_doc_distributions.id
      ')
  end

  # GET /wr_doc_distributions/1
  # GET /wr_doc_distributions/1.json
  def show
  end

  # GET /wr_doc_distributions/new
  def new
    @wr_doc_distribution = WrDocDistribution.new
  end

  def new_document_distribution
    @distribution = WrDocDistribution.new
    @wr_doc = WrDoc.find_by(wr_doc_id: params[:wr_doc_id])
  end

  # GET /wr_doc_distributions/1/edit
  def edit
  end

  # POST /wr_doc_distributions
  # POST /wr_doc_distributions.json
  def create
    if params[:wr_doc_distribution][:wr_doc_id].present?
      @params = params[:wr_doc_distribution][:receiver]
      @params.each do |receiver|
        @distribution = WrDocDistribution.new
        @distribution.wr_doc_id = params[:wr_doc_distribution][:wr_doc_id]
        # @distribution.internal_audit_id = params[:wr_doc_distribution][:internal_audit_id]
        @distribution.sender = params[:wr_doc_distribution][:sender]
        @distribution.receiver = "#{receiver}"
        @distribution.date = Time.new.strftime('%Y-%m-%d')
        @distribution.status = "Distributed - Revisi"
        @distribution.attachment_file = params[:wr_doc_distribution][:attachment_file]

        # ----------------------------------------------
        @sender = params[:wr_doc_distribution][:sender]
        @receiver = Member.find_by(username: "#{receiver}")
        @document = WrDoc.find_by_wr_doc_id(params[:wr_doc_distribution][:wr_doc_id])
        @status = "Distributed - Revisi"
        @date_distribute = Date.current.strftime("%d %B %Y")
        @document_request = WrDocRequest.find_by_id(params[:document_request])
        begin
          UserMailer.distributions_wr_docs(@sender, @receiver, @document, @status, @date_distribute, @document_request).deliver_now
        rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
          logger.warn mailing_lists_error
          flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
          return redirect_to '/errors/error_404'
        end
      end
    else
      # @distribution.wr_doc_id = params[:wr_doc_distribution][:wr_doc_id]
      @params = params[:wr_doc_distribution][:receiver]
      @params.each do |receiver|
        @distribution = WrDocDistribution.new
        # @distribution.internal_audit_id = params[:wr_doc_distribution][:internal_audit_id]
        @distribution.sender = params[:wr_doc_distribution][:sender]
        @distribution.receiver = "#{receiver}"
        @distribution.date = Time.new.strftime('%Y-%m-%d')
        @distribution.status = "Distributed - Baru"
        @distribution.attachment_file = params[:wr_doc_distribution][:attachment_file]

        #-----------------------------------------------------------------
        @sender = params[:wr_doc_distribution][:sender]
        @receiver = Member.find_by(username: "#{receiver}")
        @status = "Distributed - Baru"
        @date_distribute = Date.current.strftime("%d %B %Y")
        @document_request = WrDocRequest.find_by_id(params[:document_request])
        begin
          UserMailer.distributions_wr_docs2(@sender, @receiver, @status, @date_distribute, @document_request).deliver_now
        rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
          logger.warn mailing_lists_error
          flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
          return redirect_to '/errors/error_404'
        end
      end
    end
    respond_to do |format|
      if @distribution.save
        format.html { redirect_to index_request_wr_doc_requests_path, notice: 'Distribution was successfully created.' }
        format.json { render :show, status: :created, location: @distribution }
      else
        format.html { render :new }
        format.json { render json: @distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wr_doc_distributions/1
  # PATCH/PUT /wr_doc_distributions/1.json
  def update
    respond_to do |format|
      if @wr_doc_distribution.update(wr_doc_distribution_params)
        format.html { redirect_to @wr_doc_distribution, notice: 'Wr doc distribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @wr_doc_distribution }
      else
        format.html { render :edit }
        format.json { render json: @wr_doc_distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wr_doc_distributions/1
  # DELETE /wr_doc_distributions/1.json
  def destroy
    @wr_doc_distribution.destroy
    respond_to do |format|
      format.html { redirect_to wr_doc_distributions_url, notice: 'Wr doc distribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wr_doc_distribution
      @wr_doc_distribution = WrDocDistribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wr_doc_distribution_params
      params.require(:wr_doc_distribution).permit(:wr_doc_id, :sender, :receiver, :date, :status)
    end
end
