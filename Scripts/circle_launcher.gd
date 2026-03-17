extends Node2D



@export var enemy_health : int = 3
@export var enemy_scene : PackedScene
@export var spawn_delay : float = 3.0




@onready var fire_sound: AudioStreamPlayer2D = $FireSound
@onready var cloud_emitter: CPUParticles2D = $CloudEmitter
@onready var fire_rate: Timer = $FireRate
@onready var anim_timer: Timer = $AnimTimer
@onready var mouth_anims: AnimatedSprite2D = $MouthAnims




func _ready() -> void:
	fire_rate.start()





func spawn_enemy(world_location : Vector2, health : int):
	if enemy_scene:
		cloud_emitter.emitting = true
		fire_sound.play()
		
		
		var enemy_instance = enemy_scene.instantiate()
		get_tree().current_scene.add_child(enemy_instance)
		enemy_instance.current_health = enemy_health
		enemy_instance.global_position = world_location


func _on_fire_rate_timeout() -> void:
	mouth_anims.play("default")
	anim_timer.start()
	


func _on_anim_timer_timeout() -> void:
	spawn_enemy(global_position, enemy_health)
	fire_rate.start(spawn_delay)
