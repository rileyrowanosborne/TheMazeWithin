extends Node2D



@onready var death_timer: Timer = $DeathTimer

@export var floor_enemy_cap : int
@export var current_level : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.museum_active = true
	GameState.player_playing = true
	GameState.current_chapter = current_level
	GameState.floor_enemies_cap = floor_enemy_cap
	
	
	SignalBus.connect("player_died", on_player_died)
	
	

func on_player_died():
	death_timer.start(1.5)


func _on_death_timer_timeout() -> void:
	get_tree().reload_current_scene()
