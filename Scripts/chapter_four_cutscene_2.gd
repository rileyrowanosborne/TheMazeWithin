extends Node2D


@onready var change_scene_timer: Timer = $ChangeSceneTimer


func _ready() -> void:
	change_scene_timer.start()


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_one.tscn")
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Menu Select"):
		get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_one.tscn")
