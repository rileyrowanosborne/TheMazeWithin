extends Node2D


@export var circle_scene: PackedScene


var spawn_location_1 : Vector2 = Vector2(101, -413)
var spawn_location_2 : Vector2 = Vector2(393, -396)
var spawn_location_3 : Vector2 = Vector2(247, -526)

func _ready() -> void:
	SignalBus.connect("orm_reset", on_orm_reset)




func spawn_circle(world_location : Vector2):
	if circle_scene:
		var circle_instance = circle_scene.instantiate()
		get_tree().current_scene.add_child(circle_instance)
		circle_instance.global_position = world_location

func on_orm_reset():
	spawn_circle(spawn_location_1)
	spawn_circle(spawn_location_2)
	spawn_circle(spawn_location_3)
