# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  sub_field = $('#wr_doc_request_wr_doc_id').html()
  # $('#wr_doc_sub_field_id').empty()
  console.log(sub_field)
  $('#wr_doc_request_wr_doc_type_id').change ->
    field = $('#wr_doc_request_wr_doc_type_id :selected').text()
    options = $(sub_field).filter("optgroup[label='#{field}']").html()
    if options
      # body...
      $('#wr_doc_request_wr_doc_id').html(options)
    else
      $('#wr_doc_request_wr_doc_id').empty()
