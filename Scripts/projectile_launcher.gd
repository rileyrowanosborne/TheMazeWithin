extends Node2D


@export var projectile_scene : PackedScene


@export var direction : Vector2


@onready var fire_rate: Timer = $FireRate

const RED_PROJECTILE = preload("res://Assets/Sprites/Projectile.png")
const GREEN_PROJECTILE = preload("res://Assets/Sprites/GreenProjectile.png")
const BLUE_PROJECTILE = preload("res://Assets/Sprites/BlueProjectile.png")


@export var fire_rate_delay : float = 1.0


func _ready() -> void:
	
	if get_parent().get_parent().is_shooting  == true:
		fire_rate.start()




func spawn_projectile(world_location : Vector2, dir : Vector2):
	if projectile_scene:
		var projectile_instance = projectile_scene.instantiate()
		get_tree().current_scene.add_child(projectile_instance)
		projectile_instance.global_position = world_location
		projectile_instance.dir = dir
		projectile_instance.apply_central_impulse(dir * 100)
		if owner.is_in_group("Square"):
			projectile_instance.sprite_2d.texture = RED_PROJECTILE
		elif owner.is_in_group("Triangle"):
			projectile_instance.sprite_2d.texture = GREEN_PROJECTILE
		elif owner.is_in_group("Circle"):
			projectile_instance.sprite_2d.texture = BLUE_PROJECTILE
		


func _on_fire_rate_timeout() -> void:
	if get_parent().get_parent().is_shooting:
		spawn_projectile(global_position, direction)
	fire_rate.start()
