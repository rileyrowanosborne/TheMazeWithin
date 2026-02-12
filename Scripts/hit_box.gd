extends Area2D
class_name hitbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Hitbox")



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hurtbox"):
		if area.has_method("take_damage"):
			area.take_damage()
