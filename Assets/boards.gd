class_name Boards
extends Node3D

@export
var boards: Array[Board]

func toggle_boards(index_to_active: int):
	for board in boards:
		board.toggle_has_result(index_to_active)

func check_board_has_result(index: int):
	return boards[index].has_result

func set_has_result(index: int):
	boards[index].has_result = true

func get_boards_has_result() -> Array[int]:
	var current_index: int = 0
	var indexes: Array[int] = []
	for board in boards:
		if !board.has_result:
			indexes.push_front(current_index)
		current_index += 1
	return indexes
