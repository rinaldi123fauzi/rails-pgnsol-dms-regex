class DistributionsController < ApplicationController
  before_action :set_distribution, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource
  # respond_to :html, :json
  # GET /distributions
  # GET /distributions.json

  def new_distribution
    @distribution = Distribution.new
    @document_request = DocumentRequest.find_by_id(params[:id])
  end

  def receive
    @distribution = Distribution.find(params[:id])
    @distribution.update(status: "Received")
    redirect_to distributions_url, notice: 'Status Received'
  end

  def download_document
    @distribution = Distribution.find_by_id(params[:id])
    if @distribution.present?
      send_file Rails.root.join('public', @distribution.attachment_file)
    else
      head :no_content
    end
  end

  def index
    # if current_user.is? 9
    #   @distributions = Distribution.left_outer_joins(:document,:internal_audit).where(receiver: current_user.nama).select('
    #     documents.document_code, internal_audits.report_no, distributions.sender, distributions.receiver, distributions.date,
    #     distributions.status, distributions.id
    #     ')
    # else
    #   @distributions = Distribution.left_outer_joins(:document,:internal_audit).select('
    #     documents.document_code, internal_audits.report_no, distributions.sender, distributions.receiver, distributions.date,
    #     distributions.status, distributions.id
    #     ')
    # end
    if current_user.is? 10
      @distributions = Distribution.left_outer_joins(:document, :internal_audit).where(receiver: current_user.username).select('
          documents.document_code, internal_audits.report_no, distributions.sender, distributions.receiver, distributions.date,
          distributions.status, distributions.id
          ')
    elsif current_user.is? 2
    @distributions = Distribution.left_outer_joins(:document, :internal_audit).select('
        documents.document_code, internal_audits.report_no, distributions.sender, distributions.receiver, distributions.date,
        distributions.status, distributions.id
        ')
  end
end

# GET /distributions/1
# GET /distributions/1.json
def show
end

# GET /distributions/new
def new
  @distribution = Distribution.new
end

def new_document_distribution
  @distribution = Distribution.new
  @document = Document.find_by(document_id: params[:document_id])
end

# GET /distributions/1/edit
def edit
end

# POST /distributions
# POST /distributions.json
def create
  # @distribution = Distribution.new(distribution_params)
  if params[:distribution][:document_id].present?
    @params = params[:distribution][:receiver]
    @params.each do |receiver|
      @distribution = Distribution.new
      @distribution.document_id = params[:distribution][:document_id]
      # @distribution.internal_audit_id = params[:distribution][:internal_audit_id]
      @distribution.sender = params[:distribution][:sender]
      @distribution.receiver = "#{receiver}"
      @distribution.date = Time.new.strftime('%Y-%m-%d')
      @distribution.status = "Distributed - Revisi"
      @distribution.attachment_file = params[:distribution][:attachment_file]

      # ----------------------------------------------
      @sender = params[:distribution][:sender]
      @receiver = Member.find_by(username: "#{receiver}")
      @document = Document.find_by_document_id(params[:distribution][:document_id])
      @status = "Distributed - Revisi"
      @date_distribute = Date.current.strftime("%d %B %Y")
      @document_request = DocumentRequest.find_by_id(params[:document_request])
      begin
      UserMailer.distributions_qms(@sender, @receiver, @document, @status, @date_distribute, @document_request).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    end
  else
    # @distribution.document_id = params[:distribution][:document_id]
    @params = params[:distribution][:receiver]
    @params.each do |receiver|
      @distribution = Distribution.new
      # @distribution.internal_audit_id = params[:distribution][:internal_audit_id]
      @distribution.sender = params[:distribution][:sender]
      @distribution.receiver = "#{receiver}"
      @distribution.date = Time.new.strftime('%Y-%m-%d')
      @distribution.status = "Distributed - Baru"
      @distribution.attachment_file = params[:distribution][:attachment_file]

      #-----------------------------------------------------------------
      @sender = params[:distribution][:sender]
      @receiver = Member.find_by(username: "#{receiver}")
      @status = "Distributed - Baru"
      @date_distribute = Date.current.strftime("%d %B %Y")
      @document_request = DocumentRequest.find_by_id(params[:document_request])
      begin
        UserMailer.distributions_qms2(@sender, @receiver, @status, @date_distribute, @document_request).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    end
  end
  respond_to do |format|
    if @distribution.save
      format.html { redirect_to index_request_document_requests_path, notice: 'Distribution was successfully created.' }
      format.json { render :show, status: :created, location: @distribution }
    else
      format.html { render :new }
      format.json { render json: @distribution.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /distributions/1
# PATCH/PUT /distributions/1.json
def update
  respond_to do |format|
    if @distribution.update(distribution_params)
      format.html { redirect_to @distribution, notice: 'Distribution was successfully updated.' }
      format.json { render :show, status: :ok, location: @distribution }
    else
      format.html { render :edit }
      format.json { render json: @distribution.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /distributions/1
# DELETE /distributions/1.json
def destroy
  @distribution.destroy
  respond_to do |format|
    format.html { redirect_to distributions_url, notice: 'Distribution was successfully destroyed.' }
    format.json { head :no_content }
  end
end

private

# Use callbacks to share common setup or constraints between actions.
def set_distribution
  @distribution = Distribution.find(params[:id])
end

# Never trust parameters from the scary internet, only allow the white list through.
def distribution_params
  params.require(:distribution).permit(:document_id, :internal_audit_id, :sender, :receiver, :date)
end

end
