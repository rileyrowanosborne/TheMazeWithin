extends Node2D


@onready var shield_break_timer: Timer = $ShieldBreakTimer
@onready var top_shield_segment: AnimatedSprite2D = $Hurtbox/TopShieldSegment
@onready var right_shield_segment: AnimatedSprite2D = $Hurtbox/RightShieldSegment
@onready var left_shield_segment: AnimatedSprite2D = $Hurtbox/LeftShieldSegment
@onready var bottom_shield_segment: AnimatedSprite2D = $Hurtbox/BottomShieldSegment
@onready var shield_break: AudioStreamPlayer2D = $ShieldBreak


func _ready() -> void:
	add_to_group("Shield")



func take_damage():
	shield_break.play()
	top_shield_segment.play("Hit")
	right_shield_segment.play("Hit")
	left_shield_segment.play("Hit")
	bottom_shield_segment.play("Hit")
	get_parent().is_hittable = true
	shield_break_timer.start()


func _on_shield_break_timer_timeout() -> void:
	queue_free()
