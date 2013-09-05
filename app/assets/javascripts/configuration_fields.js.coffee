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
	if $(".record-rows").size() <= 0
		$("#no-record-error").html("<div class='alert fade in alert-error' id='no-record-error'>No Records: Please add records to generate file</div>")
		return false
	else
		$("#no-record-error").html("<div id='no-record-error'></div>")
		$("#file_date").val(getDate())
		$("#file_time").val(getTime())
		$("#file_base_currency_code").val($("#base-currency-code").val())
		$("#file_fcc_acquirer_id").val($("#fcc-acquirer-id").val())
		$("#file_version").val($("#version").val())
		$("#filename_form").submit()

# Validate forms
$("#generator_form").validate()
$("#filename_form").validate
  invalidHandler: () ->
    $("#generate_file_form").submit (e) ->
  	  e.preventDefault()


  submitHandler: ->
      $("#generate_file_form").unbind('submit').submit()

	

		
# submit form
$("#add-record").on "click", -> 
	$("#generator_form").submit()

#validation class rules
jQuery.validator.addClassRules
  digits:
    digits: true

  required:
    required: true

  email:
  	email: true


# Datepicker for date input fields
$("#creation-date, #installation-date, #date-of-last-update").datepicker({ dateFormat: 'yymmdd' })

# Reset record count display on click
$(".delete-record").on "click", ->
	$("table#content-table tbody tr").each (index, element) ->
		$(element).children().first("td").text index + 1 + "."