extends Node2D



@export var enemy_health : int = 3
@export var enemy_scene : PackedScene
@export var spawn_delay : float = 3.0
@export var floor_crystal_active : bool = true





@onready var fire_sound: AudioStreamPlayer2D = $FireSound
@onready var cloud_emitter: CPUParticles2D = $CloudEmitter
@onready var fire_rate: Timer = $FireRate
@onready var anim_timer: Timer = $AnimTimer
@onready var mouth_anims: AnimatedSprite2D = $MouthAnims
@onready var cloud_emitter_2: CPUParticles2D = $CloudEmitter2





func _ready() -> void:
	fire_rate.start()
	SignalBus.connect("crystal_break", _on_crystal_break)
	SignalBus.connect("enemy_died", on_enemy_died)
	SignalBus.connect("player_died", on_player_died)
	
	





func spawn_enemy(world_location : Vector2, health : int):
	if enemy_scene:
		
		if GameState.floor_enemies_spawned < GameState.floor_enemies_cap:
			GameState.floor_enemies_spawned += 1
			print(GameState.floor_enemies_spawned)
		
			cloud_emitter.emitting = true
			fire_sound.play()
			
			
			var enemy_instance = enemy_scene.instantiate()
			get_tree().current_scene.add_child(enemy_instance)
			enemy_instance.current_health = enemy_health
			enemy_instance.global_position = world_location
		
		else:
			cloud_emitter_2.emitting = true
			print("spawn cap reached")


func _on_fire_rate_timeout() -> void:
	mouth_anims.play("default")
	anim_timer.start()
	


func _on_anim_timer_timeout() -> void:
	if floor_crystal_active:
		spawn_enemy(global_position, enemy_health)
	else:
		queue_free()
	fire_rate.start(spawn_delay)

func on_player_died():
	GameState.floor_enemies_spawned = 0

func on_enemy_died():
	GameState.floor_enemies_spawned -= 1


func _on_crystal_break():
	floor_crystal_active = false
