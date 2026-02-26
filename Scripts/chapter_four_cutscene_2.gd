extends Node2D


@onready var change_scene_timer: Timer = $ChangeSceneTimer


func _ready() -> void:
	change_scene_timer.start()


func _on_change_scene_timer_timeout() -> void:
	pass
	
