extends CharacterBody2D




var player_in_range : bool = false

func _on_in_range_checker_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true


func _on_in_range_checker_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		SignalBus.emit_signal("end_quork_dialogue")


func _input(event: InputEvent) -> void:
	if player_in_range:
		if event.is_action_pressed("Interact"):
			SignalBus.emit_signal("begin_quork_dialogue")
