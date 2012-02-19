# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$(".room_reservation_uavl").tooltip()
	
	$(".room_reservation_avl:not(.disabled)").live "click", ->
		values = {}
		$.each $(@).parent().serializeArray(), (i,field) ->
			values[field.name] = field.value
		$(@).removeClass("room_reservation_avl").addClass("room_reservation_self disabled")
		that = @
		$.post "/room_bookings", values, (data)->
			$(that).data("booking", data.id)
			$(that).removeClass("btn-success disabled").addClass("btn-danger")
			$(that).html("<i class='icon-remove icon-white'></i>")
			console.log(data)
			str = "<div class='alert alert-success' data-pushed ='#{new Date()}'>You have reserved #{data.room} at #{data.reserved_at} </div>"
			$("#room_reservation_summary").prepend(str)

	$(".room_reservation_self:not(.disabled)").live "click", ->
		id = $(@).data("booking")
		$(@).removeClass("room_reservation_self").addClass("room_reservation_avl disabled")
		that = @
		$.post  "/room_bookings/#{id}", {_method: 'delete'}, (data)->
			$(that).removeClass("btn-danger disabled").addClass("btn-success")
			$(that).html("<i class='icon-ok icon-white'></i>")
			str = "<div class='alert alert-success' data-pushed ='#{new Date()}'>#{data}</div>"
			$("#room_reservation_summary").prepend(str)



removeOldReservations = ->
	for elem in $("#room_reservation_summary")
		console.log elem.value
