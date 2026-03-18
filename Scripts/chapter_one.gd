extends Node2D


@export var chapter_seed : int
@export var boss_location : Vector2
@export var boss_health : int

@export var current_level : int

@export var normal_spawn : Vector2
@export var checkpoint_spawn : Vector2

var level_boss_is_spawned : bool = false


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $Player


@export var level_boss : PackedScene

var level_boss_instance


@export var total_level_spleep_holes : int
var total_spleeps_collected : int



@export var floor_enemy_cap : int



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GameState.player_playing = true
	GameState.current_chapter = current_level
	GameState.floor_enemies_cap = floor_enemy_cap
	
	SignalBus.connect("begin_boss_spawning", begin_boss_spawning)
	SignalBus.connect("open_door", open_door)
	SignalBus.connect("change_level", change_levels)
	SignalBus.connect("player_died", reset_level)
	SignalBus.connect("player_respawn", respawn_player)
	
	
	GameState.current_boss_health = boss_health
	GameState.current_floor_boss_max_health = boss_health
	GameState.current_chapter = current_level
	GameState.orm_current_phase = 1
	
	


func begin_boss_spawning():
	GameState.boss_active = true
	animated_sprite_2d.visible = true
	animated_sprite_2d.global_position = boss_location
	$BossSpawningWarningTimer.start()

func check_total_spleeps():
	if total_spleeps_collected >= total_level_spleep_holes:
		SignalBus.emit_signal("begin_boss_spawning")

func spawn_boss():
	level_boss_is_spawned = true
	if level_boss:
		level_boss_instance = level_boss.instantiate()
		get_parent().add_child(level_boss_instance)
		level_boss_instance.current_health = boss_health
		level_boss_instance.global_position = boss_location
		level_boss_instance.boss_mode_active = true



func _on_boss_spawning_warning_timer_timeout() -> void:
	spawn_boss()
	animated_sprite_2d.visible = false



func level_boss_died():
	GameState.boss_active = false
	SignalBus.emit_signal("level_boss_died")



func open_door():
	if current_level == 1:
		GameState.chapter_one_door_open = true
	elif current_level == 2:
		GameState.chapter_two_door_open = true
	elif current_level == 3:
		GameState.chapter_three_door_open = true
	elif current_level == 4:
		GameState.chapter_four_door_open = true


func change_levels():
	
	
	
	
	
	if GameState.current_chapter != 4:
		level_boss_is_spawned = false
		GameState.boss_active = false
		get_tree().change_scene_to_file("res://Scenes/Chapters/Chapter Interludes/chapter_screen.tscn")
	else:
		print("YOU WIN! add in a final cutscene transistion to the chapter script")



func reset_level():
	level_boss_is_spawned = false
	await get_tree().create_timer(1.5).timeout
	if level_boss_instance:
		level_boss_instance.queue_free()
	

func respawn_player():
	if GameState.boss_active:
		player.global_position = checkpoint_spawn
		begin_boss_spawning()
	else:
		player.global_position = normal_spawn
