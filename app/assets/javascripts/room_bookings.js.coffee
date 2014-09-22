# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$(".room_reservation_uavl").tooltip()
	
	$(".room_booking_element").on "click", "a.room_reservation_avl:not(.disabled)", ->
		values = {}
		$.each $(@).parent().serializeArray(), (i,field) ->
			values[field.name] = field.value
		$(@).removeClass("room_reservation_avl").addClass("room_reservation_self")
		$.post "/room_bookings", values, (data) =>
			$(@).data("booking", data.id)
			$(@).removeClass("btn-success disabled").addClass("btn-danger")
			$(@).html("<i class='glyphicon glyphicon-remove'></i>")
			str = "<div class='alert alert-success' data-pushed ='#{new Date()}'>You have reserved #{data.room} at #{data.reserved_at} </div>"
			$("#room_reservation_summary").html(str)

	$(".room_booking_element").on "click", ".room_reservation_self:not(.disabled)", ->
		id = $(@).data("booking")
		$(@).removeClass("room_reservation_self").addClass("room_reservation_avl disabled")
		$.post  "/room_bookings/#{id}", {_method: 'delete'}, (data) =>
			$(@).removeClass("btn-danger disabled").addClass("btn-success")
			$(@).html("<i class='glyphicon glyphicon-ok'></i>")
			str = "<div class='alert alert-danger' data-pushed ='#{new Date()}'>#{data}</div>"
			$("#room_reservation_summary").html(str)
