extends CharacterBody2D


var player_in_range : bool = false

@export var interactable_type : String




func _ready() -> void:
	add_to_group("Interactable")
	add_to_group(interactable_type)
	
	SignalBus.connect("start_mushroom_cutscene", mushroom_cutscene)



func _input(event: InputEvent) -> void:
	if player_in_range:
		if event.is_action_pressed("Interact"):
			SignalBus.emit_signal("show_dialogue")
			
			if interactable_type == "Mushroom":
				SignalBus.emit_signal("start_mushroom_cutscene")




func mushroom_cutscene():
	if interactable_type == "Mushroom":
		queue_free()
