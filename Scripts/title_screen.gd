extends Node2D

@onready var new_button: TextureButton = $VBoxContainer/NewButton
@onready var load_button: TextureButton = $VBoxContainer/LoadButton


func _ready() -> void:
	new_button.grab_focus()
	
	
	if SaveLoad.contents_to_save.current_chapter != 1:
		load_button.disabled = false
	else:
		load_button.disabled = true
	




func _on_new_button_pressed() -> void:
	print("click")
	SaveLoad.contents_to_save.current_chapter = 1
	get_tree().change_scene_to_file("res://Scenes/Chapters/Chapter Interludes/chapter_screen.tscn")


func _on_load_button_pressed() -> void:
	print("click")
	GameState.current_chapter = SaveLoad.contents_to_save.current_chapter
	
	if GameState.current_chapter == 1:
		get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_one.tscn")
	elif GameState.current_chapter == 2:
		get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_two.tscn")
	elif GameState.current_chapter == 3:
		get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_three.tscn")
	elif GameState.current_chapter == 4:
		get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_four.tscn")




func _on_quit_button_pressed() -> void:
	SaveLoad._save()
	get_tree().quit()
