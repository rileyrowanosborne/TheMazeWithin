extends Area2D



@onready var spark_anim: AnimatedSprite2D = $SparkAnim




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Projectile"):
		if body.has_method("apply_facing_impulse"):
			body.apply_facing_impulse(250)
			SignalBus.emit_signal("succesful_deflect")
			spark_anim.play("default")
	
	if body.is_in_group("Enemy"):
		if body.has_method("take_damage"):
			body.take_damage()
		if body.has_method("apply_facing_impulse"):
			body.apply_facing_impulse(250)
			spark_anim.play("default")
	
	if body.is_in_group("Orm Head"):
		
		if body.has_method("apply_facing_impulse"):
			body.apply_facing_impulse(150)
			SignalBus.emit_signal("succesful_deflect")
			spark_anim.play("default")
