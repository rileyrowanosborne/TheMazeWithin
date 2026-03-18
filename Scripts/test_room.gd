extends Node2D



@export var test_room_seed : int


@export var floor_enemy_cap : int

func _ready() -> void:
	GameState.player_playing = true
	GameState.floor_enemies_cap = floor_enemy_cap
	GameState.current_chapter = 0
