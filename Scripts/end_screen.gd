extends Node2D





func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") or event.is_action_pressed("Menu Back") or event.is_action_pressed("Menu Select"):
		get_tree().change_scene_to_file("res://Scenes/Chapters/Title Screen/title_screen.tscn")
