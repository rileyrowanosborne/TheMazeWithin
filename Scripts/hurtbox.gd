extends Area2D
class_name hurtbox



func _ready() -> void:
	add_to_group("Hurtbox")



func take_damage():
	if owner.is_in_group("Player"):
		SignalBus.emit_signal("player_hit")
