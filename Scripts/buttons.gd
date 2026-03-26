extends Control



@onready var resume_button: Button = $ResumeButton
@onready var quit_button: Button = $QuitButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("pause_game", on_game_paused)
	SignalBus.connect("unpause_game",on_game_unpaused)






func on_game_paused():
	resume_button.grab_focus()

func on_game_unpaused():
	pass



func _on_wepon_select_pressed() -> void:
	GameState.museum_active = false
	get_tree().change_scene_to_file("res://Scenes/Chapters/MiniGame/mini_game_one.tscn")
