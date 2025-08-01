extends CanvasLayer

@export
var turn_label: Label

@export
var result_label: Label

@export 
var restart_button: Button

var turn_x : String = "TURN X"
var turn_o : String = "TURN O"

var win_x: String = "X\nWIN"
var win_o: String = "O\nWIN"
var draw: String = "DRAW"

func _ready() -> void:
	GlobalSignals.change_turn.connect(change_turn)
	GlobalSignals.game_end.connect(show_result_label)

func change_turn(turn: DefaultConst.players):
	if turn == DefaultConst.players.X:
		turn_label.text = turn_x
	else:
		turn_label.text = turn_o

func show_result_label(winner: DefaultConst.players):
	if winner == DefaultConst.players.X:
		result_label.text = win_x
	elif winner == DefaultConst.players.O:
		result_label.text = win_o
	else:
		result_label.text = draw
	result_label.visible = true
	turn_label.visible = false
	restart_button.visible = true

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
