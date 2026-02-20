extends CharacterBody2D


var player_in_range : bool = false

@export var interactable_type : String




func _ready() -> void:
	add_to_group("Interactable")
	add_to_group(interactable_type)



func _input(event: InputEvent) -> void:
	if player_in_range:
		if event.is_action_pressed("Interact"):
			SignalBus.emit_signal("show_dialogue")
