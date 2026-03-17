extends Node2D




@export var slide_factor : float



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameState.current_accel = slide_factor


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameState.current_accel = GameState.NORMAL_ACCEL
