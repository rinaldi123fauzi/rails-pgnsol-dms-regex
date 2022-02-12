class DocumentRequest < ApplicationRecord
  belongs_to :document, optional: true
  belongs_to :internal_audit, optional: true
  after_create :mailer_create_request
  def mailer_create_request #Else status_request: new or status_request: revision
    @document = Document.find_by(document_id: self.document_id)
    @reason = self.reason_request
    @position = self.position
    @division = self.division
    @request = self.requester
    @user = Permission.joins(:member).where('role_id = ? and members.status = ? or role_id = ? and members.status = ?', 2, "Active", 6, "Active").select('*')
    @user.each do |f|
      @member = f.email
      begin
        UserMailer.document_request(@member, @document, @reason, @position, @division, @request).deliver_now
      rescue Net::SMTPFatalError, Net::SMTPSyntaxError, Net::SMTPAuthenticationError => mailing_lists_error
        # logger.warn mailing_lists_error
        # flash.discard[:notice] = "There was a problem with sending to destination email.  Please give information to the ICT " + "#{mailing_lists_error}"
        # return redirect_to '/errors/error_404'
      end
    end
  end
end
