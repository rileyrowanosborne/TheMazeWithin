extends Control


@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var player_shielded_icon: TextureRect = $PlayerShieldedIcon



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("player_hit", on_player_hit)
	SignalBus.connect("player_respawn", reset_health)



func on_player_hit():
	health_check()


func health_check():
	texture_progress_bar.value = GameState.current_player_health


func reset_health():
	texture_progress_bar.value = 4


func _process(delta: float) -> void:
	if GameState.player_special_amount > 0:
		player_shielded_icon.visible = true
	else:
		player_shielded_icon.visible = false
		
