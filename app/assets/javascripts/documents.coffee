# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#ViewAllIndex').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: false
    searching: false
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#ViewAllIndex').data('source')

  $('#ViewBaseType').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: false
    searching: false
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#ViewBaseType').data('source')

  $('#View2BaseType').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: false
    searching: false
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#View2BaseType').data('source')

  sub_field = $('#document_sub_document_type_id').html()
  classification = $('#document_document_classification_id').html()
  sub2document = $('#document_sub2_document_type_id').html()
  # $('#wr_doc_sub_field_id').empty()
  console.log(sub_field)
  $('#document_document_type_id').change ->
    field = $('#document_document_type_id :selected').text()
    options = $(sub_field).filter("optgroup[label='#{field}']").html()
    if options
# body...
      $('#document_sub_document_type_id').html(options)
      doc_class = $('#document_sub_document_type_id :selected').text()
      optionss = $(classification).filter("optgroup[label='#{doc_class}']").html()
      $('#document_document_classification_id').html(optionss)
      sub2ss = $(sub2document).filter("optgroup[label='#{doc_class}']").html()
      $('#document_sub2_document_type_id').html(sub2ss)
    else
      $('#document_sub_document_type_id').empty()


  classification = $('#document_document_classification_id').html()
  sub22 = $('#document_sub2_document_type_id').html()
  # $('#wr_doc_sub_field_id').empty()
  console.log(classification)
  $('#document_sub_document_type_id').change ->
    doc_class = $('#document_sub_document_type_id :selected').text()
    options = $(classification).filter("optgroup[label='#{doc_class}']").html()
    optionss = $(sub22).filter("optgroup[label='#{doc_class}']").html()
    if options && optionss
# body...
      $('#document_document_classification_id').html(options)
      $('#document_sub2_document_type_id').html(optionss)
    else if options
      $('#document_document_classification_id').html(options)
    else if optionss
      $('#document_sub2_document_type_id').html(optionss)
    else
      $('#document_document_classification_id').empty()
      $('#document_sub2_document_type_id').empty()
