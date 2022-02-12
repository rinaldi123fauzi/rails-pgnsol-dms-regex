#Developer : Mohamad Rinaldi Fauzi
#DB table : document_requests
#Module : QMS
#Sifat Tabel : Transaksi
#Ket : Data request dokumen di modules QMS
class DocumentRequestsController < ApplicationController
  before_action :logged_in_user, except: [:download_hard_copy]
  #before_action :token_exist?, except: [:download_hard_copy]
  before_action :set_document_request, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session #Digunakan jidak "Can't verify CSRF token authenticity"

  # GET /document_requests
  # GET /document_requests.json
  def download_hard_copy
    @document_request = DocumentRequest.joins(:document).where('document_requests.id = ? and approve_date >= ?', CGI.escapeHTML(params[:id].gsub(/['"\\\x0]/, '\\\\\0').gsub("\\", "")), Date.current - 3.day).select('*').order('document_requests.id DESC')
    # if @document_request.first.file_copy.to_s.nil? == false and @document_request.first.file_copy.to_s.empty? == false and @document_request.exists? == true
    if @document_request.exists?
      @checkUser = Member.find_by_nama(@document_request.first.requester.to_s)
      unless @checkUser.status == "Non Active"
        send_file 'public/file/DMS/Quality_Management/File_Copy/' + @document_request.first.file_copy.to_s, :type => "application/pdf", :x_sendfile => true
        @user = Member.find_by_nama(@document_request.first.requester.to_s)
        @document_code = @document_request.first.document_code.to_s
        @activity = "Document has downloaded from email"
        @member = @user.member_id
        activity_request_document(@member, @document_code, @activity)
      else
        redirect_to '/errors/error_404'
      end
    else
      # head :no_content
      redirect_to '/errors/error_404'
    end
  end

  def download
    @document_request = DocumentRequest.joins(:document).where('document_requests.id = ? and requester = ? and approve_date >= ?', params[:id], current_user.nama, Date.current - 3.day).select('*').order('document_requests.id DESC')
    # create_user_activity @document_request.first.document_code.to_s, current_user.nama + " has been downloded document with title : " + @document_request.first.document_title.to_s
    folder_path = File.join('file', 'DMS', 'Quality_Management', 'File_Copy')
    file_path = File.join(folder_path)
    if @document_request.first.file_copy.to_s.nil? == false and @document_request.first.file_copy.to_s.empty? == false and @document_request.exists? == true
      send_file Rails.root.join('public', file_path, @document_request.first.file_copy.to_s)
      @user = Member.find_by_nama(current_user.nama)
      @document_code = @document_request.first.document_code.to_s
      @activity = "Document has downloaded from application"
      @member = @user.member_id
      activity_request_document(@member, @document_code, @activity)
    else
      # head :no_content
      redirect_to document_requests_url
    end
  end

  def download_new_request
    @document_request = DocumentRequest.find_by_id(params[:id])
    # create_user_activity @document_request.first.document_code.to_s, current_user.nama + " has been downloded document with title : " + @document_request.first.document_title.to_s
    # folder_path = File.join('file', 'DMS', 'Quality_Management', 'File_Copy')
    # file_path = File.join(folder_path)
    if @document_request.present?
      send_file Rails.root.join('public', @document_request.attachment_file)
    else
      head :no_content
      # redirect_to document_requests_url
    end
  end

  def edit_approve
    @document_request = DocumentRequest.find(params[:id])
  end

  def edit_reject
    @document_request = DocumentRequest.find(params[:id])
  end

  def request_new
    @document_id = params[:document_id]
    @document_request = DocumentRequest.new
  end

  def request_pdf
    @request = DocumentRequest.joins(:document).where(id: params[:id]).select('*')
    respond_to do |format|
      format.html { head :no_content }
      format.pdf do
        # render :orientation => 'Landscape',:encoding => "utf8", :layout => "pdf_layout", pdf: "assessment_pdf.pdf"
        render :orientation => 'Portrait', :encoding => "utf8", :layout => "pdf_layout", pdf: "request_pdf" + Time.now.strftime('%Y%m%d%H%I%S')
      end
    end
  end

  def do_reject_new_request
    @document_request = DocumentRequest.find(params[:id])
    @document_request.update(status_request: "Rejected Request")
    @get_sender = Member.find_by_username(current_user.username)
    @get_receiver = Member.find_by_nama(@document_request.receiver)
    @sender_name = @get_receiver.nama
    @receiver_name = @get_sender.nama
    @receiver = @get_receiver.email
    @request_date = @document_request.request_date
    @request_status = @document_request.status_request
    @reason_request = @document_request.reason_request
    @division = @document_request.division
    if @document_request.document_id.present?
      @document = Document.find_by_document_id(@document_request.document_id)
      @sub_status_request = @document_request.sub_status_request
      @document_id = @document_request.document_id
      begin
        UserMailer.document_request_rejected_new_documents2(@document_id, @sub_status_request, @sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    else
      begin
        UserMailer.document_request_rejected_new_documents(@sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    end

    redirect_to index_request_document_requests_url, notice: "Request has been rejected"
  end

  def do_approve_new_request
    @document_request = DocumentRequest.find(params[:id])
    @document_request.update(status_request: "Approved Request")
    @get_sender = Member.find_by_username(current_user.username)
    @get_receiver = Member.find_by_nama(@document_request.receiver)
    @sender_name = @get_receiver.nama
    @receiver_name = @get_sender.nama
    @receiver = @get_receiver.email
    @request_date = @document_request.request_date
    @request_status = @document_request.status_request
    @reason_request = @document_request.reason_request
    @division = @document_request.division
    if @document_request.document_id.present?
      @document = Document.find_by_document_id(@document_request.document_id)
      @sub_status_request = @document_request.sub_status_request
      @document_id = @document_request.document_id
      begin
        UserMailer.document_request_approve_new_documents2(@document_id, @sub_status_request, @sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    else
      begin
        UserMailer.document_request_approve_new_documents(@sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    end

    redirect_to index_request_document_requests_url, notice: "Request has been approved"
  end

  def do_reject
    @document_request = DocumentRequest.find(params[:id])
    @document_request.update(status_request: "Rejected")
    # @document_request.update(approve_date: Date.current)

    @document = Document.find_by(document_id: @document_request.document_id)

    @request = Member.find_by(nama: @document_request.requester)

    @admin = current_user.nama
    create_user_activity @document.document_code, "The request of " + current_user.nama + " has been rejected with title : " + @document.document_title
    redirect_to document_requests_url, notice: "Request has been rejected"
  end

  def do_approve_by_superadmin
    @inputer_filter = Permission.joins(:member).select('*').where('permissions.role_id = ?', 6).order('members.member_id ASC')

    @inputer_filter.each do |f|
      @document_request = DocumentRequest.find(params[:id])
      @document_request.update(status_request: "Approve1")
      @document = Document.find_by(document_id: @document_request.document_id)
      @request = Member.find_by(nama: @document_request.requester)
      @inputer = f.email
      @admin = current_user.nama
      begin
        UserMailer.approve1_by_superadmin(@document_request, @document, @request, @admin, @inputer).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        # logger.warn mailing_lists_error
        # flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        # return redirect_to '/errors/error_404'
      end
    end
    create_user_activity @document.document_code, "The request of " + current_user.nama + " has been approved step 1 with title : " + @document.document_title
    redirect_to document_requests_url, notice: "Request has been approved on step 1"
  end

  def new_request
    @document_request = DocumentRequest.new
  end

  def index_request
    if current_user.is? 10
      @request = DocumentRequest.where('status_request = ? and receiver = ? or status_request = ? and receiver = ? or status_request = ? and receiver = ? or status_request = ? and receiver = ?', 'baru', current_user.username, 'revisi', current_user.username, 'Approved Request', current_user.username, 'Rejected Request', current_user.username).select('*')
      if @request.exists?
        @document_requests = DocumentRequest.left_outer_joins(:document).where('receiver = ? and status_request = ? or receiver = ? and status_request = ? or receiver = ? and status_request = ? or receiver = ? and status_request = ?', current_user.nama, "baru", current_user.nama, "revisi", current_user.nama, "Approved Request", current_user.nama, "Rejected Request").select('*').order('documents.document_date DESC')
      else
        @document_requests = DocumentRequest.left_outer_joins(:document).where('requester = ? and status_request = ? or requester = ? and status_request = ? or requester = ? and status_request = ? or requester = ? and status_request = ?', current_user.nama, "baru", current_user.nama, "revisi", current_user.nama, "Approved Request", current_user.nama, "Rejected Request").select('*').order('documents.document_date DESC')
      end
    else
      @document_requests = DocumentRequest.left_outer_joins(:document).where('status_request = ? and receiver = ? or status_request = ? and receiver = ? or status_request = ? and receiver = ? or status_request = ? and receiver = ?', "baru", current_user.username, "revisi", current_user.username, "Approved Request", current_user.username, "Rejected Request", current_user.username).select('*').order('documents.document_date DESC')
    end
  end

  def index
    if current_user.is? 10 #staf
      @document_requests = DocumentRequest.joins(:document).where(requester: current_user.nama).where.not('status_request = ? or status_request = ? or status_request = ? or status_request = ? or status_request = ?', 'baru', 'revisi', 'Approved Request', 'Rejected Request', 'Approve1').select('*').order('document_requests.request_date DESC')
    elsif current_user.is? 6 #inputer
      @document_requests = DocumentRequest.joins(:document).where.not('status_request = ? or status_request = ? or status_request = ? or status_request = ? or status_request = ?', 'baru', 'revisi', 'Approved Request', 'Rejected Request', 'Pending Request').select('*').order('document_requests.request_date DESC')
    elsif current_user.is? 2 #superadmin
      @document_requests = DocumentRequest.joins(:document).where.not('status_request = ? or status_request = ? or status_request = ? or status_request = ?', 'baru', 'revisi', 'Approved Request', 'Rejected Request').select('*').order('document_requests.request_date DESC')
    else #superadmin
      @document_requests = DocumentRequest.joins(:document).where.not('status_request = ? or status_request = ? or status_request = ? or status_request = ? or status_request = ?', 'baru', 'revisi', 'Approved Request', 'Rejected Request', 'Pending Request').select('*').order('document_requests.request_date DESC')
    end
  end

  # GET /document_requests/1
  # GET /document_requests/1.json
  def show
  end

  # GET /document_requests/new
  def new
    @document_request = DocumentRequest.new
  end

  # GET /document_requests/1/edit
  def edit
  end

  # POST /document_requests
  # POST /document_requests.json
  def create
    # @document_request = DocumentRequest.new(document_request_params)
    if params[:status_request] == "baru" or params[:status_request] == "revisi"
      @document_request = DocumentRequest.new
      folder_path = File.join('file', 'DMS', 'Quality_Management', 'Request_Document')

      if !Dir.exist? folder_path
        FileUtils::mkdir_p (Rails.root.join('public', folder_path))
      end

      uploaded_io = params[:document_request][:attachment_file]

      file_path = File.join(folder_path, Time.new.strftime("QMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ", "_"))
      file_name = File.join(folder_path, Time.new.strftime("QMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ", "_"))
      File.open(Rails.root.join('public', file_path), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      nama_file = file_name
      @document_request.attachment_file = nama_file
      if params[:document_request][:document_id].present?
        @document_request.document_id = params[:document_request][:document_id]
      end
      @permission = Permission.find_by(permission_id: session[:id])
      @name = Member.find_by(member_id: @permission.member_id)
      @document_request.requester = "#{@name.nama}"
      @document_request.status_request = params[:status_request]
      @document_request.sub_status_request = params[:document_request][:sub_status_request]
      @document_request.reason_request = params[:document_request][:reason_request]
      @document_request.receiver = params[:document_request][:receiver]
      @document_request.division = params[:document_request][:division]
      @document_request.request_date = Date.current
      if params[:status_request] === "revisi"
        @document_request.sub_status_request = params[:document_request][:sub_status_request]
        @document_request.document_id = params[:document_request][:document_id]
      end
      @document_request.save
      # ----------------------------------------------------------------------------
      @get = Member.find_by_username(params[:document_request][:receiver])
      @sender_name = @name.nama
      @receiver_name = @get.nama
      @receiver = @get.email
      @request_date = Date.current
      @request_status = params[:status_request]
      @reason_request = params[:document_request][:reason_request]
      @division = params[:document_request][:division]
      if params[:status_request] === "revisi"
        @sub_status_request = params[:document_request][:sub_status_request]
        @document_id = params[:document_request][:document_id]
        begin
          UserMailer.document_request_new_documents2(@document_id, @sub_status_request, @sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
        rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
          logger.warn mailing_lists_error
          flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
          return redirect_to '/errors/error_404'
        end
      else
        begin
          UserMailer.document_request_new_documents(@sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
        rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
          logger.warn mailing_lists_error
          flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
          return redirect_to '/errors/error_404'
        end
      end
      redirect_to index_request_document_requests_url, notice: "Document request was successfully created."
    else
      @document_request = DocumentRequest.new
      @document_request.document_id = params[:document_request][:document_id]
      @permission = Permission.find_by(permission_id: session[:id])
      @name = Member.find_by(member_id: @permission.member_id)
      @document_request.requester = "#{@name.nama}"
      @document_request.status_request = "Pending Request"
      @document_request.reason_request = params[:document_request][:reason_request]
      @document_request.division = params[:document_request][:division]
      @document_request.position = params[:document_request][:position]
      @document_request.request_date = Date.current
      @document_request.save
      # redirect_to document_request_documents_path, notice: "Document request was successfully created."
      @document = Document.find(params[:document_request][:document_id])
      create_user_activity @document.document_code, current_user.nama + " has been requested document with title : " + @document.document_title
      redirect_to document_requests_url, notice: "Document request was successfully created."

      # respond_to do |format|
      #   if @document_request.save
      #     format.html { redirect_to @document_request, notice: 'Document request was successfully created.' }
      #     format.json { render :show, status: :created, location: @document_request }
      #   else
      #     format.html { render :new }
      #     format.json { render json: @document_request.errors, status: :unprocessable_entity }
      #   end
      # end
    end
  end

  # PATCH/PUT /document_requests/1
  # PATCH/PUT /document_requests/1.json
  def update
    ##################REJECTED
    if params[:document_request][:reject_reason].present?
      @document_request = DocumentRequest.find(params[:id])
      @document_request.update(status_request: "Rejected")
      @document_request.update(reject_reason: params[:document_request][:reject_reason])
      @document = Document.find_by(document_id: @document_request.document_id)

      @request = Member.find_by(nama: @document_request.requester)

      @member = params[:member]
      @admin = params[:nama]

      begin
        UserMailer.document_request_reject(@document_request, @document, @request, @admin).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        # logger.warn mailing_lists_error
        # flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        # return redirect_to '/errors/error_404'
      end
      activity_request_document @member, @document.document_code, "The request of " + @request.nama + " has been rejected with title : " + @document.document_title
      # redirect_to document_requests_path, notice: "Request has been rejected", turbolinks: false
      redirect_back(fallback_location: root_path, :notice => "Request has been rejected.")
      #####################APPROVE
    else
      @document = DocumentRequest.joins(:document).where(id: params[:id]).select('*')
      # abort @document.first.document_code.to_s.inspect
      folder_path = File.join('file', 'DMS', 'Quality_Management', 'File_Copy')

      if !Dir.exist? folder_path
        FileUtils::mkdir_p (Rails.root.join('public', folder_path))
      end

      uploaded_io = params[:document_request][:file_copy]
      file_extention = File.extname(uploaded_io.original_filename)
      rename = @document.first.document_code.to_s.gsub('/', '-') + file_extention

      file_path = File.join(folder_path, Time.new.strftime("COPY-QMS%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
      file_name = File.join(Time.new.strftime("COPY-QMS%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
      File.open(Rails.root.join('public', file_path), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      nama_file = file_name

      @document_request = DocumentRequest.find(params[:id])
      @document_request.update(file_copy: nama_file)
      @document_request.update(status_request: "Approved")
      @document_request.update(approve_date: Date.current)
      @document_request.update(end_date: Date.current + 3.days)

      @document = Document.find_by(document_id: @document_request.document_id)

      @request = Member.find_by(nama: @document_request.requester)

      @member = params[:member]
      @admin = params[:nama]

      begin
        UserMailer.document_request_approval(@document_request, @document, @request, @admin).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        # logger.warn mailing_lists_error
        # flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        # return redirect_to '/errors/error_404'
      end
      activity_request_document @member, @document.document_code, "The request of " + @request.nama + " has been approved with title : " + @document.document_title
      redirect_to document_requests_url, notice: "Request has been approved"
    end

    # respond_to do |format|
    #   if @document_request.update(document_request_params)
    #     format.html { redirect_to @document_request, notice: 'Document request was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @document_request }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @document_request.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /document_requests/1
  # DELETE /document_requests/1.json
  def destroy
    @document_request.destroy
    respond_to do |format|
      format.html { redirect_to document_requests_url, notice: 'Document request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document_request
    @document_request = DocumentRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_request_params
    params.require(:document_request).permit(:document_id, :internal_audit_id, :requester, :status_request, :reason_request, :document_reference_id, :request_date, :approve_date, :end_date, :file_copy, :division, @position, :receiver, :attachment_file, :sub_status_request)
  end

end
