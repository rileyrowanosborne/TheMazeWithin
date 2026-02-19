extends Node2D




func _ready() -> void:
	GameState.current_chapter = 1

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Chapters/Chapter Interludes/chapter_screen.tscn")
