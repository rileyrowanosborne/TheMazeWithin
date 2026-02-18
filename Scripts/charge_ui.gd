extends Node2D


@onready var progress: Sprite2D = $Progress

const CHARGED = preload("res://Assets/Sprites/ChargeProgressBarOver.png")
const NOT_CHARGED = preload("res://Assets/Sprites/ChargeProgressBarProgress.png")

func _process(delta: float) -> void:
	if GameState.is_swinging:
		progress.texture = NOT_CHARGED
	else:
		progress.texture = CHARGED
