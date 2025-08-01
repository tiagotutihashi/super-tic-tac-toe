class_name GameController
extends Camera3D

var game_manager: GameManager

func _ready() -> void:
	game_manager = get_node("/root/Node3D/GameManager")

func _input(event):
	if event.is_action_pressed("click"):
		shoot_ray()

func shoot_ray():
	if game_manager.get_end_game():
		return
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	if !raycast_result.is_empty():
		var playable_space = raycast_result["collider"].get_parent()
		if(playable_space):
			playable_space.place_current_player()
