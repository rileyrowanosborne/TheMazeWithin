extends Node2D


func _ready() -> void:
	
	$SceneChangeTimer.start()


func _on_scene_change_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
