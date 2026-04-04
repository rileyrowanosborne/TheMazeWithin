extends Node2D

@onready var change_scene_timer: Timer = $ChangeSceneTimer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_scene_timer.start()



func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Menu Select") or event.is_action_pressed("Swing"):
		get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_four.tscn")


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_four.tscn")
