extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Projectile"):
		if body.has_method("apply_facing_impulse"):
			body.apply_facing_impulse(250)
			SignalBus.emit_signal("succesful_deflect")
	
	if body.is_in_group("Enemy"):
		if body.has_method("take_damage"):
			body.take_damage()
		if body.has_method("apply_facing_impulse"):
			body.apply_facing_impulse(250)
	
	if body.is_in_group("Orm Head"):
		if body.has_method("apply_facing_impulse"):
			body.apply_facing_impulse(250)
