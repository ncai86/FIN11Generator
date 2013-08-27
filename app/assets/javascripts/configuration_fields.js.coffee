# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# removing disabled form fields
$.each gon.hiddenFields, (index, v) ->
  $("#" + v).parents("tr").remove()

# reset form
$("#reset-button").on "click", ->
  $("#generator_form")[0].reset()

# Set date & time
$("#generate_file").on "click", ->
	$("#file_date").val(getDate())
	$("#file_time").val(getTime())
	$("#file_base_currency_code").val($("#base-currency-code").val())
	$("#file_fcc_acquirer_id").val($("#fcc-acquirer-id").val())
	$("#file_version").val($("#version").val())
	$("#file_sequence_no").val($("#sequence-no").val())

# submit form
$("#add-record").on "click", -> 
	$("#generator_form").submit()

