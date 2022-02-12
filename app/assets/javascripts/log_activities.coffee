# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#LogActivityIndex').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: false
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#LogActivityIndex').data('source')

  $('#LisRequestLogActivity').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: false
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#LisRequestLogActivity').data('source')

  $('#ListLoginLogActivity').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: false
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#ListLoginLogActivity').data('source')