class_name MainMenu
extends Control

@export var base_scene: PackedScene
@export var super_scene: PackedScene

func _on_normal_button_pressed() -> void:
	get_tree().change_scene_to_packed(base_scene)

func _on_super_button_pressed() -> void:
	get_tree().change_scene_to_packed(super_scene)
