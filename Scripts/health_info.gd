extends Control


@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("player_hit", on_player_hit)
	SignalBus.connect("player_respawn", reset_health)



func on_player_hit():
	health_check()


func health_check():
	texture_progress_bar.value = GameState.current_player_health


func reset_health():
	texture_progress_bar.value = 3
