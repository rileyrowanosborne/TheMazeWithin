extends Node2D


@onready var top_shield_segment: AnimatedSprite2D = $Hurtbox/TopShieldSegment
@onready var right_shield_segment: AnimatedSprite2D = $Hurtbox/RightShieldSegment
@onready var left_shield_segment: AnimatedSprite2D = $Hurtbox/LeftShieldSegment
@onready var bottom_shield_segment: AnimatedSprite2D = $Hurtbox/BottomShieldSegment


func _ready() -> void:
	add_to_group("Shield")



func take_damage():
	top_shield_segment.play("Hit")
	right_shield_segment.play("Hit")
	left_shield_segment.play("Hit")
	bottom_shield_segment.play("Hit")
	get_parent().is_hittable = true
	get_parent().shield_break()



func _on_top_shield_segment_animation_finished() -> void:
	if top_shield_segment.animation == "Hit":
		queue_free()
