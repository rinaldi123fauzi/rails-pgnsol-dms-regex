class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.document_receiver.subject
  #
  def wr_document_request_approval(wr_doc_request, document, request, admin)
    #code
    @document = document
    @wr_doc_request = wr_doc_request
    @request = request
    @admin = admin
    @greeting = "Hi"
    mail to: @request.email, subject: "Approval Permintaan Dokumen Referensi"
  end

  def wr_document_request(member, document, reason, division, position, request)
    #code
    @division = division
    @position = position
    @member = member
    @document = document
    @reason = reason
    @request = request
    @greeting = "Hi"
    mail to: @member, subject: "Permintaan Dokumen Referensi"
  end

  def document_request_approval(document_request, document, request, admin)
    #code
    @document = document
    @document_request = document_request
    @request = request
    @admin = admin
    @greeting = "Hi"
    mail to: @request.email, subject: "Approval Permintaan Dokumen Quality"
  end

  def document_request_reject(document_request, document, request, admin)
    #code
    @document = document
    @document_request = document_request
    @request = request
    @admin = admin
    @greeting = "Hi"
    mail to: @request.email, subject: "Reject Permintaan Dokumen Quality"
  end

  def document_request(member, document, reason, position, division, request)
    #code
    @position = position
    @division = division
    @member = member
    @document = document
    @reason = reason
    @request = request
    @greeting = "Hi"
    mail to: @member, subject: "Permintaan Dokumen Quality"
  end

  def approve1_by_superadmin(document_request, document, request, admin, inputer)
    #code
    @document_request = document_request
    @document = document
    @modul = 'Quality Document'
    @request = request
    @admin = admin
    @inputer = inputer
    @greeting = "Hi"
    mail to: @inputer, subject: "Approve1 by Superadmin (DMS)"
  end

  def approve1_by_superadmin_wreference(document_request, document, request, admin, inputer)
    #code
    @document_request = document_request
    @document = document
    @request = request
    @modul = 'Reference Document'
    @admin = admin
    @inputer = inputer
    @greeting = "Hi"
    mail to: @inputer, subject: "Approve1 by Superadmin (DMS)"
  end


  ############pending proses#################

  def document_request_new_documents(sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "DMS REQ QMS Document"
  end

  def document_request_new_documents2(document_id, sub_status_request, sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @document_id = document_id
    @document = Document.find_by_document_id(@document_id)
    @sub_status_request = sub_status_request
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "DMS REQ QMS Document"
  end

  def document_request_approve_new_documents(sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "DMS REQ QMS Document"
  end

  def document_request_approve_new_documents2(document_id, sub_status_request, sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @document_id = document_id
    @document = Document.find_by_document_id(@document_id)
    @sub_status_request = sub_status_request
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "DMS REQ QMS Document"
  end

  def document_request_rejected_new_documents(sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "DMS REQ QMS Document"
  end

  def document_request_rejected_new_documents2(document_id, sub_status_request, sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @document_id = document_id
    @document = Document.find_by_document_id(@document_id)
    @sub_status_request = sub_status_request
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "DMS REQ QMS Document"
  end

  def distributions_qms(sender, receiver, document, status, date_distribute, document_request)
    @greeting = "Hi"
    @sender = sender
    @receiver = receiver
    @document = document
    @status = status
    @date_distribute = date_distribute
    @document_request = document_request

    mail to: @receiver.email, subject: "DMS Information"
  end

  def distributions_qms2(sender, receiver, status, date_distribute, document_request)
    @greeting = "Hi"
    @sender = sender
    @receiver = receiver
    @status = status
    @date_distribute = date_distribute
    @document_request = document_request

    mail to: @receiver.email, subject: "DMS Information"
  end

  ############################# WORK REFERENCE DOCUMENT ################################
  def wr_doc_request_reject(wr_doc_request, wr_doc, request, admin)
    #code
    @document = wr_doc
    @document_request = wr_doc_request
    @request = request
    @admin = admin
    @greeting = "Hi"
    mail to: @request.email, subject: "Reject Permintaan Dokumen Referensi"
  end

  def document_request_new_wr_docs(sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "REQ Reference Document"
  end

  def document_request_new_wr_docs2(wr_doc_id, sub_status_request, sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @wr_doc_id = wr_doc_id
    @document = WrDoc.find_by_wr_doc_id(@wr_doc_id)
    @sub_status_request = sub_status_request
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "REQ Reference Document"
  end

  def document_request_approve_new_wr_docs(sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "REQ Reference Document"
  end

  def document_request_approve_new_wr_docs2(wr_doc_id, sub_status_request, sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @wr_doc_id = wr_doc_id
    @document = WrDoc.find_by_wr_doc_id(@wr_doc_id)
    @sub_status_request = sub_status_request
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "REQ Reference Document"
  end

  def document_request_rejected_new_wr_docs(sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "REQ Reference Document"
  end

  def document_request_rejected_new_wr_docs2(wr_doc_id, sub_status_request, sender_name, receiver_name, receiver, request_date, request_status, reason_request, division)
    #code
    @wr_doc_id = wr_doc_id
    @document = WrDoc.find_by_wr_doc_id(@wr_doc_id)
    @sub_status_request = sub_status_request
    @sender_name = sender_name
    @receiver_name = receiver_name
    @receiver = receiver
    @request_date = request_date
    @request_status = request_status
    @reason_request = reason_request
    @division = division
    @greeting = "Hi"
    mail to: @receiver, subject: "REQ Reference Document"
  end

  def distributions_wr_docs(sender, receiver, document, status, date_distribute, document_request)
    @greeting = "Hi"
    @sender = sender
    @receiver = receiver
    @document = document
    @status = status
    @date_distribute = date_distribute
    @document_request = document_request

    mail to: @receiver.email, subject: "Reference Document of Distribution"
  end

  def distributions_wr_docs2(sender, receiver, status, date_distribute, document_request)
    @greeting = "Hi"
    @sender = sender
    @receiver = receiver
    @status = status
    @date_distribute = date_distribute
    @document_request = document_request

    mail to: @receiver.email, subject: "Reference Document of Distribution"
  end

  ###################################### END ###########################################

  def document_receiver_report(user)
    @greeting = "Hi"

    @user = user

    mail to: @user.email, subject: "DMS Information"
  end

  def document_receiver_wr_docs(user)
    @greeting = "Hi"

    @user = user

    mail to: @user.email, subject: "DMS Information"
  end
end
