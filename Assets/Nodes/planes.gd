class_name Planes
extends Node3D

@export
var planes: Array[MeshInstance3D]

var default_material: Material
var current_material: Material

func set_current_playable(index):
	var current_index = 0
	for plane in planes:
		if current_index == index:
			plane.set_surface_override_material(0, current_material)
		else:
			plane.set_surface_override_material(0, default_material)
		current_index += 1

func set_current_array(indexes: Array[int]):
	var current_index = 0
	for plane in planes:
		plane.set_surface_override_material(0, default_material)
		if current_index in indexes:
			plane.set_surface_override_material(0, current_material)
		current_index += 1

func _ready() -> void:
	default_material = planes[0].mesh.surface_get_material(0)
	current_material = planes[0].mesh.surface_get_material(0).duplicate()
	current_material.albedo_color = Color.LIGHT_GREEN
