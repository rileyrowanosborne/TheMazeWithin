extends Control


@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("player_hit", on_player_hit)



func on_player_hit():
	health_check()


func health_check():
	texture_progress_bar.value = GameState.player_health
