// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui-1.10.3.custom.js
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require bootstrap
//= require_tree .
//= require jquery.remotipart


function getDate(){
	var date = new Date();
	var year = date.getFullYear().toString();
	var month = ('0' + (date.getMonth()+1)).slice(-2);
	var day = ('0' + date.getDate().toString()).slice(-2);
	return ( year + month + day);
}

function getTime(){
	var date = new Date();
	var hour = ('0' + date.getHours().toString()).slice(-2);
	var min = ('0' + date.getMinutes().toString()).slice(-2);
	var sec = ('0' + date.getSeconds().toString()).slice(-2);
	return ( hour + min + sec );
}