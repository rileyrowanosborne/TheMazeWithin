extends Control



@onready var resume_button: Button = $ResumeButton
@onready var quit_button: Button = $QuitButton
@onready var mini_game_one: Node2D = $"../../MiniGameOne"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("pause_game", on_game_paused)
	SignalBus.connect("unpause_game",on_game_unpaused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if resume_button.position.x < -230:
		resume_button.position.x = 1160
	
	if quit_button.position.x < -230:
		quit_button.position.x = 1160
	
	
	
	resume_button.position.x -= 50 * delta
	quit_button.position.x -= 50 * delta



func on_game_paused():
	resume_button.grab_focus()

func on_game_unpaused():
	pass



func _on_wepon_select_pressed() -> void:
	GameState.museum_active = false
	mini_game_one.visible = true
	
