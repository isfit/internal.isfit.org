# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
jQuery ->
	$("#internal_tab_controller").change ->
  	$.post "/internal_tabs/get_actions.js", {controller_js:this.value}, (data)	->
    	$("#internal_tab_action").html(data)
	$.post "/internal_tabs/get_actions.js", {controller_js:$("#internal_tab_controller").val()}, (data)	->
    $("#internal_tab_action").html(data)
