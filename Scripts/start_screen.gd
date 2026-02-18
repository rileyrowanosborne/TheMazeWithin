extends Node2D


func _on_start_button_pressed() -> void:
	GameState.current_chapter = 1
	get_tree().change_scene_to_file("res://Scenes/chapter_screen.tscn")
