extends Node2D


func _ready() -> void:
	
	$SceneChangeTimer.start()


func _on_scene_change_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Chapters/Title Screen/title_screen.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Menu Select") or event.is_action_pressed("Swing"):
		get_tree().change_scene_to_file("res://Scenes/Chapters/Title Screen/title_screen.tscn")
