class_name Board
extends Node

@export
var lines: Array[BoardLine]

@export
var index: int

@export
var game_manager: GameManager

@export
var playable = true

var has_result = false

var piece_placed = 0
var max_piece = 9

var win_situations = [
	[1,2,3], 
	[4,5,6],
	[7,8,9],
	[1,4,7],
	[2,5,8],
	[3,6,9],
	[1,5,9],
	[3,5,7]
]

func set_main_board_win(winner: DefaultConst.players, win_index: int):
	var to_place: PlayableSpace
	if win_index <= 2:
		to_place = lines[0].object_placed[win_index]
	elif win_index >=3 && win_index <= 5:
		to_place = lines[1].object_placed[win_index-3]
	else:
		to_place = lines[2].object_placed[win_index-6]
	to_place.place_object(winner)
	game_manager.change_player(to_place)

func disable_lines():
	for line in lines:
		line.disable_places(true)

func enable_lines():
	for line in lines:
		line.disable_places(false)

func toggle_has_result(index_to_active: int):
	if !has_result:
		if index == index_to_active || index_to_active < 0:
			enable_lines()
		else:
			disable_lines()
	else:
			disable_lines()

func check_result():
	piece_placed += 1
	var reached_max = false
	if piece_placed >= max_piece:
		reached_max = true
		disable_lines()
	var x_placed = [];
	var o_placed = [];
	for line in lines:
		var result_line = line.check_line()
		x_placed.append_array(result_line["x_placed"])
		o_placed.append_array(result_line["o_placed"])
	
	var won = DefaultConst.players.EMPTY
	for win_line in win_situations:
		var x_count = 0
		var o_count = 0
		for win in win_line:
			if win in x_placed:
				x_count += 1
			if win in o_placed:
				o_count += 1
		if x_count == 3:
			won = DefaultConst.players.X
			disable_lines()
		elif o_count == 3:
			won = DefaultConst.players.O
			disable_lines()
	return {
		"won": won,
		"max_pieces": reached_max,
		"index": index
	}
