extends Node2D


@onready var blood_splat_1: CPUParticles2D = $BloodSplat1
@onready var blood_splat_2: CPUParticles2D = $BloodSplat2



@export var max_health : int
var min_health : int = 0
var current_health : int


func _ready() -> void:
	SignalBus.connect("player_hit", on_player_hit)
	current_health = max_health


func on_player_hit():
	if not GameState.player_is_invul:
		current_health -= 1
		blood_splat_1.emitting = true
		blood_splat_2.emitting = true
		health_check()
		print("Hit!")
	else:
		print("Dogded!")
	


func health_check():
	if get_parent().is_in_group("Player"):
		if current_health < min_health:
			SignalBus.emit_signal("player_died")
