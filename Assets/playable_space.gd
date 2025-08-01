class_name PlayableSpace
extends Area3D

@onready
var x_object : MeshInstance3D = $x_001
@onready
var o_object : MeshInstance3D = $o

@onready
var static_body = $StaticBody3D/CollisionShape3D2

@export
var game_manger : GameManager

var line: BoardLine
@export
var index: int = 0

var placed_object: DefaultConst.players = DefaultConst.players.EMPTY

func _ready() -> void:
	game_manger = get_node("/root/Node3D/GameManager")
	line = get_parent()

func _on_mouse_entered() -> void:
	if placed_object != DefaultConst.players.EMPTY:
		return
	if game_manger.player_turn == DefaultConst.players.X:
		place_x()
	elif  game_manger.player_turn == DefaultConst.players.O:
		place_o()
	else:
		place_empty()

func _on_mouse_exited() -> void:
	if placed_object == DefaultConst.players.EMPTY:
		place_empty()

func place_x():
	x_object.visible = true
	o_object.visible = false

func place_o():
	x_object.visible = false
	o_object.visible = true

func place_both():
	x_object.visible = true
	o_object.visible = true

func place_empty():
	x_object.visible = false
	o_object.visible = false

func place_object(new_object: DefaultConst.players):
	placed_object = new_object
	if new_object == DefaultConst.players.X:
		place_x()
	elif new_object == DefaultConst.players.O:
		place_o()
	elif new_object == DefaultConst.players.BOTH:
		place_both()
	else:
		place_empty()

func place_current_player():
	if(!game_manger):
		return
	if placed_object != DefaultConst.players.EMPTY:
		return
	place_object(game_manger.get_player_turn())
	game_manger.change_player(self)

func get_placed_object():
	return placed_object

func get_line():
	return line

func get_board():
	return line.get_board()

func ger_place_index():
	return index
