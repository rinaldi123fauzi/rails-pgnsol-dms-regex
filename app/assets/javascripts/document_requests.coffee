# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  sub_field = $('#document_request_document_id').html()
  # $('#wr_doc_sub_field_id').empty()
  console.log(sub_field)
  $('#document_request_document_reference_id').change ->
    field = $('#document_request_document_reference_id :selected').text()
    options = $(sub_field).filter("optgroup[label='#{field}']").html()
    if options
      # body...
      $('#document_request_document_id').html(options)
    else
      $('#document_request_document_id').empty()
