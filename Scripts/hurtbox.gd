extends Area2D


func _ready() -> void:
	add_to_group("Hurtbox")


func take_damage():
	if get_parent().is_in_group("Player"):
		if GameState.player_alive:
			print("Player hit!")
			SignalBus.emit_signal("player_hit")
	
	if get_parent().is_in_group("Enemy"):
		if get_parent().has_method("take_damage"):
			get_parent().take_damage()
