extends Node2D


@onready var shield_segment_sprite: AnimatedSprite2D = $Hurtbox/ShieldSegmentSprite
@onready var collision_shape_2d: CollisionShape2D = $Hurtbox/CollisionShape2D


func _ready() -> void:
	add_to_group("Shield")



func take_damage():
	shield_segment_sprite.play("Hit")
	get_parent().is_hittable = true
	get_parent().shield_break()


func _on_shield_segment_sprite_animation_finished() -> void:
	if shield_segment_sprite.animation == "Hit":
		queue_free()
