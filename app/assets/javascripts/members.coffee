# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
email =  $('#email').html()
nama =  $('#nama').html()
console.log(email)
$('#username').change ->
  username = $('#username').val()
  console.log(username)
  username = $('#username :selected').text()
#   options = $(email).filter("optgroup[label='#{username}']").html()
#   $('#email').html(options)


  userSelectBox = $('#email')
  userSelectBox = $('#nama')
  userSelectBox.html('')
  if username.length == 0
    userSelectBox.append($('<input>').type('text').attr('value'))
  else
      option = $('#email')
        .attr('value', username + '@pgn-solution.co.id')

      option = $('#nama')
        .attr('value', username.replace(".", " ").toUpperCase())
      userSelectBox.append option

$('#IndexUser').dataTable
  sPaginationType: "full_numbers"
  bJQueryUI: false
  bProcessing: true
  bServerSide: true
  sAjaxSource: $('#IndexUser').data('source')