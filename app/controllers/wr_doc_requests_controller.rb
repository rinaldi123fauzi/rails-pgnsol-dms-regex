#Developer : Mohamad Rinaldi Fauzi
#DB table : wr_doc_requests
#Module : WR (Work References)
#Sifat Tabel : Transaksi
#Ket : Data request
class WrDocRequestsController < ApplicationController
  before_action :logged_in_user, except: [:download_hard_copy]
  #before_action :token_exist?, except: [:download_hard_copy]
  before_action :set_wr_doc_request, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session #Digunakan jidak "Can't verify CSRF token authenticity"

  # GET /wr_doc_requests
  # GET /wr_doc_requests.json
  def download_hard_copy
    @wr_doc_request = WrDocRequest.joins(:wr_doc).where('wr_doc_requests.id = ? and approve_date >= ?', CGI.escapeHTML(params[:id].gsub(/['"\\\x0]/, '\\\\\0').gsub("\\", "")), Date.current - 3.day).select('*').order('wr_doc_requests.id DESC')
    # if @wr_doc_request.first.file_copy.to_s.nil? == false and @wr_doc_request.first.file_copy.to_s.empty? == false and @wr_doc_request.exists? == true
    if @wr_doc_request.exists?
      @checkUser = Member.find_by_nama(@wr_doc_request.first.requester.to_s)
      unless @checkUser.status == "Non Active"
        send_file 'public/file/DMS/Work_Reference/File_Copy/' + @wr_doc_request.first.file_copy.to_s, :type => "application/pdf", :x_sendfile => true
        @user = Member.find_by_nama(@wr_doc_request.first.requester.to_s)
        @document_code = @wr_doc_request.first.document_code.to_s
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
    @document_request = WrDocRequest.joins(:wr_doc).where('wr_doc_requests.id = ? and requester = ? and approve_date >= ?', params[:id], current_user.nama, Date.current - 3.day).select('*').order('wr_doc_requests.id DESC')
    create_user_activity @document_request.first.document_code.to_s, current_user.nama + " has been downloded document with title : " + @document_request.first.document_title.to_s
    folder_path = File.join('file', 'DMS', 'Work_Reference', 'File_Copy')
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
    @document_request = WrDocRequest.find_by_id(params[:id])
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
    @wr_doc_request = WrDocRequest.find(params[:id])
  end

  def edit_reject
    @wr_doc_request = WrDocRequest.find(params[:id])
  end

  def request_new
    @wr_doc_id = params[:wr_doc_id]
    @wr_doc_request = WrDocRequest.new
  end

  def do_reject
    @wr_doc_request = WrDocRequest.find(params[:id])
    @wr_doc_request.update(status_request: "Rejected")
    # @wr_doc_request.update(approve_date: Date.current)
    @document = WrDoc.find_by(wr_doc_id: @wr_doc_request.wr_doc_id)

    @request = Member.find_by(nama: @wr_doc_request.requester)

    @admin = current_user.nama
    create_user_activity @document.document_code, "The request of " + current_user.nama + " has been rejected with title : " + @document.document_title
    redirect_to wr_doc_requests_url, notice: "Request has been rejected"
  end

  def do_approve_by_superadmin
    @inputer_filter = Permission.joins(:member).select('*').where('permissions.role_id = ?', 7).order('members.member_id ASC')

    @inputer_filter.each do |f|
      @document_request = WrDocRequest.find(params[:id])
      @document_request.update(status_request: "Approve1")
      @document = WrDoc.find_by(wr_doc_id: @document_request.wr_doc_id)
      @request = Member.find_by(nama: @document_request.requester)
      @inputer = f.email
      @admin = current_user.nama
      begin
        UserMailer.approve1_by_superadmin_wreference(@document_request, @document, @request, @admin, @inputer).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    end
    create_user_activity @document.document_code, "The request of " + current_user.nama + " has been approve1 by superadmin with title : " + @document.document_title
    redirect_to wr_doc_requests_url, notice: "Request has been approved"
  end

  def do_reject_new_request
    @document_request = WrDocRequest.find(params[:id])
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
    if @document_request.wr_doc_id.present?
      @document = WrDoc.find_by_wr_doc_id(@document_request.wr_doc_id)
      @sub_status_request = @document_request.sub_status_request
      @wr_doc_id = @document_request.wr_doc_id
      begin
        UserMailer.document_request_rejected_new_wr_docs2(@wr_doc_id, @sub_status_request, @sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    else
      begin
        UserMailer.document_request_rejected_new_wr_docs(@sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    end

    redirect_to index_request_wr_doc_requests_url, notice: "Request has been rejected"
  end

  def do_approve_new_request
    @document_request = WrDocRequest.find(params[:id])
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
    if @document_request.wr_doc_id.present?
      @document = WrDoc.find_by_wr_doc_id(@document_request.wr_doc_id)
      @sub_status_request = @document_request.sub_status_request
      @wr_doc_id = @document_request.wr_doc_id
      begin
        UserMailer.document_request_approve_new_wr_docs2(@wr_doc_id, @sub_status_request, @sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    else
      begin
        UserMailer.document_request_approve_new_wr_docs(@sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
    end

    redirect_to index_request_wr_doc_requests_url, notice: "Request has been approved"
  end

  def new_request
    @wr_doc_request = WrDocRequest.new
  end

  def index_request
    if current_user.is? 10
      @request = WrDocRequest.where('status_request = ? and receiver = ? or status_request = ? and receiver = ? or status_request = ? and receiver = ? or status_request = ? and receiver = ?', 'baru', current_user.username, 'revisi', current_user.username, 'Approved Request', current_user.username, 'Rejected Request', current_user.username).select('*')
      if @request.exists?
        @document_requests = WrDocRequest.left_outer_joins(:wr_doc).where('receiver = ? and status_request = ? or receiver = ? and status_request = ? or receiver = ? and status_request = ? or receiver = ? and status_request = ?', current_user.nama, "baru", current_user.nama, "revisi", current_user.nama, "Approved Request", current_user.nama, "Rejected Request").select('*').order('wr_docs.date DESC')
      else
        @document_requests = WrDocRequest.left_outer_joins(:wr_doc).where('requester = ? and status_request = ? or requester = ? and status_request = ? or requester = ? and status_request = ? or requester = ? and status_request = ?', current_user.nama, "baru", current_user.nama, "revisi", current_user.nama, "Approved Request", current_user.nama, "Rejected Request").select('*').order('wr_docs.date DESC')
      end
    else
      @document_requests = WrDocRequest.left_outer_joins(:wr_doc).where('status_request = ? and receiver = ? or status_request = ? and receiver = ? or status_request = ? and receiver = ? or status_request = ? and receiver = ?', "baru", current_user.username, "revisi", current_user.username, "Approved Request", current_user.username, "Rejected Request", current_user.username).select('*').order('wr_docs.date DESC')
    end
  end

  def index
    # @wr_doc_requests = WrDocRequest.all
    if current_user.is? 10
      @wr_doc_requests = WrDocRequest.joins(:wr_doc).where(requester: current_user.nama).select('*').order('wr_doc_requests.request_date DESC')
    elsif current_user.is? 7 #inputer
      @wr_doc_requests = WrDocRequest.joins(:wr_doc).where.not('status_request = ? or status_request = ? or status_request = ? or status_request = ? or status_request = ?', 'baru', 'revisi', 'Approved Request', 'Rejected Request', 'Pending Request').select('*').order('wr_doc_requests.request_date DESC')
    else #superadmin
      @wr_doc_requests = WrDocRequest.joins(:wr_doc).where.not('status_request = ? or status_request = ? or status_request = ? or status_request = ?', 'baru', 'revisi', 'Approved Request', 'Rejected Request').select('*').order('wr_doc_requests.request_date DESC')
    end
  end

  # GET /wr_doc_requests/1
  # GET /wr_doc_requests/1.json
  def show
  end

  # GET /wr_doc_requests/new
  def new
    @wr_doc_request = WrDocRequest.new
  end

  # GET /wr_doc_requests/1/edit
  def edit
  end

  # POST /wr_doc_requests
  # POST /wr_doc_requests.json
  def create
    if params[:status_request] == "baru" or params[:status_request] == "revisi"
      @wr_doc_request = WrDocRequest.new
      folder_path = File.join('file', 'DMS', 'Quality_Management', 'Request_Document')

      if !Dir.exist? folder_path
        FileUtils::mkdir_p (Rails.root.join('public', folder_path))
      end

      uploaded_io = params[:wr_doc_request][:attachment_file]

      file_path = File.join(folder_path, Time.new.strftime("QMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ", "_"))
      file_name = File.join(folder_path, Time.new.strftime("QMS%Y%m_%H%M%S") + "_" + uploaded_io.original_filename.gsub(" ", "_"))
      File.open(Rails.root.join('public', file_path), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      nama_file = file_name
      @wr_doc_request.attachment_file = nama_file
      if params[:wr_doc_request][:wr_doc_id].present?
        @wr_doc_request.wr_doc_id = params[:wr_doc_request][:wr_doc_id]
      end
      @permission = Permission.find_by(permission_id: session[:id])
      @name = Member.find_by(member_id: @permission.member_id)
      @wr_doc_request.requester = "#{@name.nama}"
      @wr_doc_request.status_request = params[:status_request]
      @wr_doc_request.sub_status_request = params[:wr_doc_request][:sub_status_request]
      @wr_doc_request.reason_request = params[:wr_doc_request][:reason_request]
      @wr_doc_request.receiver = params[:wr_doc_request][:receiver]
      @wr_doc_request.division = params[:wr_doc_request][:division]
      @wr_doc_request.request_date = Date.current
      if params[:status_request] === "revisi"
        @wr_doc_request.sub_status_request = params[:wr_doc_request][:sub_status_request]
        @wr_doc_request.wr_doc_id = params[:wr_doc_request][:wr_doc_id]
      end
      @wr_doc_request.save
      # ----------------------------------------------------------------------------
      @get = Member.find_by_username(params[:wr_doc_request][:receiver])
      @sender_name = @name.nama
      @receiver_name = @get.nama
      @receiver = @get.email
      @request_date = Date.current
      @request_status = params[:status_request]
      @reason_request = params[:wr_doc_request][:reason_request]
      @division = params[:wr_doc_request][:division]
      if params[:status_request] === "revisi"
        @sub_status_request = params[:wr_doc_request][:sub_status_request]
        @wr_doc_id = params[:wr_doc_request][:wr_doc_id]
        begin
          UserMailer.document_request_new_wr_docs2(@wr_doc_id, @sub_status_request, @sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
        rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
          logger.warn mailing_lists_error
          flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
          return redirect_to '/errors/error_404'
        end
      else
        begin
          UserMailer.document_request_new_wr_docs(@sender_name, @receiver_name, @receiver, @request_date, @request_status, @reason_request, @division).deliver_now
        rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
          logger.warn mailing_lists_error
          flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
          return redirect_to '/errors/error_404'
        end
      end
      redirect_to index_request_wr_doc_requests_url, notice: "Document request was successfully created."
    else
      @wr_doc_request = WrDocRequest.new
      @wr_doc_request.wr_doc_id = params[:wr_doc_request][:wr_doc_id]
      @permission = Permission.find_by(permission_id: session[:id])
      @name = Member.find_by(member_id: @permission.member_id)
      @wr_doc_request.requester = "#{@name.nama}"
      @wr_doc_request.status_request = "Pending Request"
      @wr_doc_request.reason_request = params[:wr_doc_request][:reason_request]
      @wr_doc_request.division = params[:wr_doc_request][:division]
      @wr_doc_request.position = params[:wr_doc_request][:position]
      @wr_doc_request.request_date = Date.current
      @wr_doc_request.save
      # redirect_to wr_doc_request_documents_path, notice: "Document request was successfully created."
      @document = WrDoc.find(params[:wr_doc_request][:wr_doc_id])
      create_user_activity @document.document_code, current_user.nama + " has been requested document with title : " + @document.document_title

      @document = WrDoc.find_by(wr_doc_id: params[:wr_doc_request][:wr_doc_id])
      @reason = params[:wr_doc_request][:reason_request]
      @division = params[:wr_doc_request][:division]
      @position = params[:wr_doc_request][:position]
      @request = current_user.nama
      @user = Permission.joins(:member).where('role_id = ? and members.status = ? or role_id = ? and members.status = ?', 2, "Active", 7, "Active").select('*')
      @user.each do |f|
        @member = f.email
        begin
          UserMailer.wr_document_request(@member, @document, @reason, @division, @position, @request).deliver_now
        rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
          logger.warn mailing_lists_error
          flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
          return redirect_to '/errors/error_404'
        end
      end
      
      redirect_to wr_doc_requests_url, notice: "Document request was successfully created."

      # respond_to do |format|
      #   if @wr_doc_request.save
      #     format.html { redirect_to @wr_doc_request, notice: 'Document request was successfully created.' }
      #     format.json { render :show, status: :created, location: @wr_doc_request }
      #   else
      #     format.html { render :new }
      #     format.json { render json: @wr_doc_request.errors, status: :unprocessable_entity }
      #   end
      # end
    end
  end

  # PATCH/PUT /wr_doc_requests/1
  # PATCH/PUT /wr_doc_requests/1.json
  def update
    if params[:wr_doc_request][:reject_reason].present?
      @wr_doc_request = WrDocRequest.find(params[:id])
      @wr_doc_request.update(status_request: "Rejected")
      @wr_doc_request.update(reject_reason: params[:wr_doc_request][:reject_reason])
      @wr_doc = WrDoc.find_by(wr_doc_id: @wr_doc_request.wr_doc_id)

      @request = Member.find_by(nama: @wr_doc_request.requester)

      @member = params[:member]
      @admin = params[:nama]

      begin
        UserMailer.wr_doc_request_reject(@wr_doc_request, @wr_doc, @request, @admin).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
      activity_request_document @member, @wr_doc.document_code, "The request of " + @request.nama + " has been rejected with title : " + @wr_doc.document_title
      # redirect_to document_requests_path, notice: "Request has been rejected", turbolinks: false
      redirect_to :back, notice: "Request has been rejected"
      #####################APPROVE
    else
      @document = WrDocRequest.joins(:wr_doc).where(id: params[:id]).select('*')
      # abort @document.first.document_code.to_s.inspect
      folder_path = File.join('file', 'DMS', 'Work_Reference', 'File_Copy')

      if !Dir.exist? folder_path
        FileUtils::mkdir_p (Rails.root.join('public', folder_path))
      end

      uploaded_io = params[:wr_doc_request][:file_copy]
      file_extention = File.extname(uploaded_io.original_filename)
      rename = @document.first.document_code.to_s.gsub('/', '-') + file_extention

      file_path = File.join(folder_path, Time.new.strftime("COPY-WR%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
      file_name = File.join(Time.new.strftime("COPY-WR%Y%m_%H%M%S") + "_" + rename.gsub(" ", "_"))
      File.open(Rails.root.join('public', file_path), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      nama_file = file_name

      @document_request = WrDocRequest.find(params[:id])
      @document_request.update(file_copy: nama_file)
      @document_request.update(status_request: "Approved")
      @document_request.update(approve_date: Date.current)
      @document_request.update(end_date: Date.current + 3.days)

      @document = WrDoc.find_by(wr_doc_id: @document_request.wr_doc_id)

      @request = Member.find_by(nama: @document_request.requester)

      @member = params[:member]
      @admin = params[:nama]

      begin
        UserMailer.wr_document_request_approval(@document_request, @document, @request, @admin).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        logger.warn mailing_lists_error
        flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        return redirect_to '/errors/error_404'
      end
      activity_request_document @member, @document.document_code, "The request of " + @request.nama + " has been approved with title : " + @document.document_title
      redirect_to wr_doc_requests_url, notice: "Request has been approved"
      # respond_to do |format|
      #   if @wr_doc_request.update(wr_doc_request_params)
      #     format.html { redirect_to @wr_doc_request, notice: 'Wr doc request was successfully updated.' }
      #     format.json { render :show, status: :ok, location: @wr_doc_request }
      #   else
      #     format.html { render :edit }
      #     format.json { render json: @wr_doc_request.errors, status: :unprocessable_entity }
      #   end
      # end
    end
  end

  # DELETE /wr_doc_requests/1
  # DELETE /wr_doc_requests/1.json
  def destroy
    @wr_doc_request.destroy
    respond_to do |format|
      format.html { redirect_to wr_doc_requests_url, notice: 'Wr doc request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_wr_doc_request
    @wr_doc_request = WrDocRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def wr_doc_request_params
    params.require(:wr_doc_request).permit(:wr_doc_id, :requester, :status_request, :reason_request, :wr_doc_type_id, :request_date, :approve_date, :end_date, :file_copy, :division, :position)
  end
end
