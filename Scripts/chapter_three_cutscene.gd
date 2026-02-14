extends Node2D

@onready var change_scene_timer: Timer = $ChangeSceneTimer


var scene_length : float = 4.0

func _ready() -> void:
	change_scene_timer.start(scene_length)
	


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Blink"):
		change_scene_timer.start(scene_length)


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/chapter_three.tscn")
