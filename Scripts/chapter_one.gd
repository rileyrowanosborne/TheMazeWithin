extends Node2D


@export var chapter_seed : int
@export var boss_location : Vector2
@export var boss_health : int

@export var current_level : int

var level_boss_is_spawned : bool = false



@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@export var level_boss : PackedScene

var level_boss_instance


@export var total_level_spleep_holes : int
var total_spleeps_collected : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("begin_boss_spawning", begin_boss_spawning)
	SignalBus.connect("change_level", change_levels)
	SignalBus.connect("player_died", reset_level)
	
	
	GameState.current_boss_health = boss_health
	GameState.current_floor_boss_max_health = boss_health
	GameState.current_chapter = current_level
	GameState.orm_current_phase = 1


func begin_boss_spawning():
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
	SignalBus.emit_signal("level_boss_died")




func change_levels():
	if GameState.current_chapter != 4:
		level_boss_is_spawned = false
		get_tree().change_scene_to_file("res://Scenes/chapter_screen.tscn")
	else:
		print("YOU WIN! add in a final cutscene transistion to the chapter script")



func reset_level():
	level_boss_is_spawned = false
	total_spleeps_collected = 0
	await get_tree().create_timer(1.5).timeout
	if level_boss_instance:
		level_boss_instance.queue_free()
	
	
