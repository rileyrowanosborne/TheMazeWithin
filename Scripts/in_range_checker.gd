extends Area2D





func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Interactable"):
		body.player_in_range = true
		SignalBus.emit_signal("show_interact_text")
	
	if body.is_in_group("Quork"):
		GameState.current_dialogue = "Quork"
	
	elif body.is_in_group("Mushroom"):
		GameState.current_dialogue = "Mushroom"


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Interactable"):
		SignalBus.emit_signal("hide_dialogue")
		body.player_in_range = false
		SignalBus.emit_signal("hide_interact_text")
