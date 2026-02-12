extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Hitbox")



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hurtbox"):
		if area.has_method("take_damage"):
			area.take_damage()
			if GameState.player_is_invul:
				print("player slid past that one!")
			else:
				get_parent().queue_free()
