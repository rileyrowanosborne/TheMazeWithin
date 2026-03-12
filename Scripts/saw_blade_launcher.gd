extends Node2D



@export var projectile_scene : PackedScene
@onready var fire_sound: AudioStreamPlayer2D = $FireSound
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D



@export var direction : Vector2
@export var initial_fire_rate_delay : float = 1.0
@export var normal_fire_rate_delay : float = 2.0



@onready var fire_rate: Timer = $FireRate



func _ready() -> void:
	fire_rate.start(initial_fire_rate_delay)





func spawn_projectile(world_location : Vector2, dir : Vector2):
	if projectile_scene:
		fire_sound.play()
		cpu_particles_2d.emitting = true
		var projectile_instance = projectile_scene.instantiate()
		get_tree().current_scene.add_child(projectile_instance)
		projectile_instance.global_position = world_location
		projectile_instance.dir = dir
		projectile_instance.apply_central_impulse(dir * 25)


func _on_fire_rate_timeout() -> void:
	spawn_projectile(global_position, direction)
	fire_rate.start(normal_fire_rate_delay)
