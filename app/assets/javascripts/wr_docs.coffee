# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#ViewAllIndex').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: false
    retrieve: true
    searching: false
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#ViewAllIndex').data('source')

  $('#ViewIndex').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: false
    retrieve: true
    searching: false
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#ViewIndex').data('source')

  $('#View2Index').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: false
    retrieve: true
    searching: false
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#View2Index').data('source')

  $('#View3Index').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: false
    retrieve: true
    searching: false
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#View3Index').data('source')

  sub_field = $('#wr_doc_sub_field_id').html()
  sub2_field = $('#wr_doc_sub2_field_id').html()
  sub3_field = $('#wr_doc_sub3_field_id').html()
  sub4_field = $('#wr_doc_sub4_field_id').html()
  # $('#wr_doc_sub_field_id').empty()
  console.log(sub_field)
  $('#wr_doc_field_id').change ->
    field = $('#wr_doc_field_id :selected').text()
    options = $(sub_field).filter("optgroup[label='#{field}']").html()
    if options
      # body...
      $('#wr_doc_sub_field_id').html(options)
      doc_class = $('#wr_doc_sub_field_id :selected').text()
      optionss = $(sub2_field).filter("optgroup[label='#{doc_class}']").html()
      $('#wr_doc_sub2_field_id').html(optionss)
      doc_class = $('#wr_doc_sub2_field_id :selected').text()
      optionss = $(sub3_field).filter("optgroup[label='#{doc_class}']").html()
      $('#wr_doc_sub3_field_id').html(optionss)
      doc_class3 = $('#wr_doc_sub3_field_id :selected').text()
      optionss4 = $(sub4_field).filter("optgroup[label='#{doc_class3}']").html()
      $('#wr_doc_sub4_field_id').html(optionss4)
    else
      $('#wr_doc_sub_field_id').empty()

  sub2_field = $('#wr_doc_sub2_field_id').html()
  sub3_field = $('#wr_doc_sub3_field_id').html()
  sub4_field = $('#wr_doc_sub4_field_id').html()
  # $('#wr_doc_sub_field_id').empty()
  console.log(sub_field)
  $('#wr_doc_sub_field_id').change ->
    field = $('#wr_doc_sub_field_id :selected').text()
    options = $(sub2_field).filter("optgroup[label='#{field}']").html()
    if options
# body...
      $('#wr_doc_sub2_field_id').html(options)
      doc_class = $('#wr_doc_sub2_field_id :selected').text()
      optionss = $(sub3_field).filter("optgroup[label='#{doc_class}']").html()
      $('#wr_doc_sub3_field_id').html(optionss)
      doc_class3 = $('#wr_doc_sub3_field_id :selected').text()
      optionss4 = $(sub4_field).filter("optgroup[label='#{doc_class3}']").html()
      $('#wr_doc_sub4_field_id').html(optionss4)
    else
      $('#wr_doc_sub2_field_id').empty()
      $('#wr_doc_sub3_field_id').empty()
      $('#wr_doc_sub4_field_id').empty()

  sub3_field = $('#wr_doc_sub3_field_id').html()
  sub4_field = $('#wr_doc_sub4_field_id').html()
  # $('#wr_doc_sub_field_id').empty()
  console.log(sub_field)
  $('#wr_doc_sub2_field_id').change ->
    field = $('#wr_doc_sub2_field_id :selected').text()
    options = $(sub3_field).filter("optgroup[label='#{field}']").html()
    if options
# body...
      $('#wr_doc_sub3_field_id').html(options)
      doc_class3 = $('#wr_doc_sub3_field_id :selected').text()
      optionss4 = $(sub4_field).filter("optgroup[label='#{doc_class3}']").html()
      $('#wr_doc_sub4_field_id').html(optionss4)
    else
      $('#wr_doc_sub3_field_id').empty()
      $('#wr_doc_sub4_field_id').empty()

  sub4_field = $('#wr_doc_sub4_field_id').html()
  # $('#wr_doc_sub_field_id').empty()
  console.log(sub_field)
  $('#wr_doc_sub3_field_id').change ->
    field = $('#wr_doc_sub3_field_id :selected').text()
    options = $(sub4_field).filter("optgroup[label='#{field}']").html()
    if options
# body...
      $('#wr_doc_sub4_field_id').html(options)
    else
      $('#wr_doc_sub4_field_id').empty()