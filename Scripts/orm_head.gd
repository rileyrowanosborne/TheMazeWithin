extends Area2D



@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



@export var left_or_right : bool




func _ready() -> void:
	animated_sprite_2d.flip_h = left_or_right
