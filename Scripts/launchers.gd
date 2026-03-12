extends Node2D



@export var is_shooting : bool = true



func _ready() -> void:
	add_to_group("World")
