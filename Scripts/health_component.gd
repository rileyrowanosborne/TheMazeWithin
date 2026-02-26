extends Node2D



const ENEMY_HIT = preload("uid://bolrjvoektlma")
const BONE_CRUNCH = preload("uid://cikptbvd24kyn")
const HURT_BONE_CRUNCH = preload("uid://4ci7ri5715xt")


var random_number_picker : int




@onready var blood_splat_1: CPUParticles2D = $BloodSplat1
@onready var blood_splat_2: CPUParticles2D = $BloodSplat2

@onready var hurt_noise: AudioStreamPlayer2D = $HurtNoise


@onready var death: AudioStreamPlayer2D = $Death
@onready var dodge: AudioStreamPlayer2D = $Dodge



@export var max_health : int
var min_health : int = 0
var current_health : int


func _ready() -> void:
	SignalBus.connect("player_hit", on_player_hit)
	current_health = max_health
	GameState.player_health = max_health


func on_player_hit():
	if GameState.player_alive:
		if GameState.player_is_invul:
			print("Dodged!")
			dodge.play()
		else:
			random_number_picker = randi_range(1,3)
			
			current_health -= 1
			blood_splat_1.emitting = true
			blood_splat_2.emitting = true
			if random_number_picker == 1:
				hurt_noise.stream = BONE_CRUNCH
			elif random_number_picker == 2:
				hurt_noise.stream = ENEMY_HIT
			elif random_number_picker == 3:
				hurt_noise.stream = HURT_BONE_CRUNCH
			
			hurt_noise.play()
			
			health_check()
			print("Hit!")
		


func health_check():
	GameState.player_health = current_health
	if GameState.player_alive:
		if get_parent().is_in_group("Player"):
			if current_health <= min_health:
				GameState.player_alive = false
				SignalBus.emit_signal("player_died")
				death.play()
