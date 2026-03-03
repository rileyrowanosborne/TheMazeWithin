extends Node2D


@onready var start_timer: Timer = $StartTimer

@onready var windows: AnimatedSprite2D = $Windows
@onready var eyes: AnimatedSprite2D = $Eyes



func _ready() -> void:
	start_timer.start(1)


func _on_start_timer_timeout() -> void:
	windows.play("default")
	eyes.play("default")
