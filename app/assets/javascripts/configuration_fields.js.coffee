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
	if $(".record-row").size() <= 0
		$("#no-record-error").html("<div class='alert fade in alert-error' id='no-record-error'>No Records: Please add records to generate file</div>")
		return false
	else
		$("#no-record-error").html("<div id='no-record-error'></div>")
		$("#file_date").val(getDate())
		$("#file_time").val(getTime())
		$("#file_base_currency_code").val($("#base-currency-code").val())
		$("#file_fcc_acquirer_id").val($("#fcc-acquirer-id").val())
		$("#file_version").val($("#version").val())
	
# submit form
$("#add-record").on "click", -> 
	$("#generator_form").submit()

# Datepicker for date input fields
$("#creation-date, #installation-date, #date-of-last-update").datepicker({ dateFormat: 'yymmdd' })

