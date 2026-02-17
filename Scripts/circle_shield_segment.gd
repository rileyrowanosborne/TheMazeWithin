extends Node2D


@onready var shield_break_timer: Timer = $ShieldBreakTimer
@onready var shield_segment_sprite: AnimatedSprite2D = $Hurtbox/ShieldSegmentSprite


func _ready() -> void:
	add_to_group("Shield")



func take_damage():
	shield_segment_sprite.play("Hit")
	get_parent().is_hittable = true
	shield_break_timer.start()




func _on_shield_break_timer_timeout() -> void:
	queue_free()
