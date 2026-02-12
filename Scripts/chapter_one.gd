extends Node2D


@export var chapter_seed : int
@export var boss_location : Vector2
@export var boss_health : int

@export var current_level : int

var level_boss_is_spawned : bool = false



@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@export var level_boss : PackedScene


@export var total_level_spleep_holes : int
var total_spleeps_collected : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("begin_boss_spawning", begin_boss_spawning)
	SignalBus.connect("change_level", change_levels)
	



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
		var level_boss_instance = level_boss.instantiate()
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
	level_boss_is_spawned = false
	if GameState.current_chapter == 1:
		GameState.current_chapter += 1
		get_tree().change_scene_to_file("res://Scenes/chapter_screen.tscn")
