class_name BoardLine
extends Node3D

@export
var object_placed: Array[PlayableSpace]

var board: Board

func _ready() -> void:
	board = get_parent()
	disable_places(!board.playable)

func disable_places(to_set_disabled):
	for node in object_placed:
		node.static_body.disabled = to_set_disabled

func check_line():
	var x_placed = []
	var o_placed = []
	for obj in object_placed:
		var placed = obj.get_placed_object()
		if(placed == DefaultConst.players.X):
			x_placed.push_front(obj.ger_place_index())
		elif placed == DefaultConst.players.O:
			o_placed.push_front(obj.ger_place_index())
		elif placed == DefaultConst.players.BOTH:
			x_placed.push_front(obj.ger_place_index())
			o_placed.push_front(obj.ger_place_index())
	return {
		"x_placed": x_placed,
		"o_placed": o_placed
	}

func get_board():
	return board
