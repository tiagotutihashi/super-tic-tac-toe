class_name GameManager
extends Node

var player_turn: DefaultConst.players = DefaultConst.players.X

@export
var board: Board 

@export
var boards: Boards

@export
var planes: Planes

var end_game = false

func get_end_game():
	return end_game

func get_player_turn():
	return player_turn

func change_player(playable: PlayableSpace):
	var result = playable.get_board().check_result()
	var won = result["won"]
	var max_pieces = result["max_pieces"]
	var board_index = result["index"]
	
	if board_index < 0:
		if max_pieces:
			end_game = true
			GlobalSignals.game_end.emit(won)
			return
		if won != DefaultConst.players.EMPTY:
			end_game = true
			GlobalSignals.game_end.emit(won)
			return
	
	if won != DefaultConst.players.EMPTY:
		board.set_main_board_win(won, board_index)
		boards.set_has_result(board_index)
	
	if max_pieces && board_index >= 0:
		board.set_main_board_win(won, board_index)
		boards.set_has_result(board_index)
	
	var boards_has_result = boards.get_boards_has_result()
	
	if boards.check_board_has_result(playable.index - 1):
		planes.set_current_array(boards_has_result)
		boards.toggle_boards(-1)
	else:
		planes.set_current_playable(playable.index - 1)
		boards.toggle_boards(playable.index - 1)
	
	if(player_turn == DefaultConst.players.X):
		player_turn = DefaultConst.players.O
	else:
		player_turn = DefaultConst.players.X
	GlobalSignals.change_turn.emit(player_turn)
	
