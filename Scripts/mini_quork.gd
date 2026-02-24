extends CharacterBody2D


var player_in_range : bool = false




func _ready() -> void:
	add_to_group("Interactable")



func _input(event: InputEvent) -> void:
	pass
