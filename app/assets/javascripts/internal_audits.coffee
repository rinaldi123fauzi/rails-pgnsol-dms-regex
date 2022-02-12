# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#IndexInternalAudit').dataTable
  sPaginationType: "full_numbers"
  bJQueryUI: false
  bProcessing: true
  bServerSide: true
  sAjaxSource: $('#IndexInternalAudit').data('source')
