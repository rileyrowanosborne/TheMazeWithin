extends RigidBody2D



#node Linkage
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var raycast_timer: Timer = $RaycastTimer



#Packed Scenes
@export var deflect_particles_scene : PackedScene
@export var deflect_noise_player_scene : PackedScene


#variables
var enemy_hittable : bool = false
var dir : Vector2
var speed : float = 100.0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Projectile")
	raycast_timer.start()
	ray_cast_down.enabled = false
	ray_cast_left.enabled = false
	ray_cast_right.enabled = false
	ray_cast_up.enabled = false


func _process(delta: float) -> void:
	if ray_cast_down.is_colliding()\
	|| ray_cast_left.is_colliding()\
	|| ray_cast_right.is_colliding()\
	|| ray_cast_up.is_colliding():
		queue_free()




func apply_facing_impulse(strength):
	SignalBus.emit_signal("succesful_deflect")
	spawn_deflect_nosie()
	spawn_deflect_particles(global_position)
	var player_aim = GameState.player_aim_dir
	var projectile_position = global_position
	var deflect_direction_vector = player_aim.normalized()
	
	
	apply_central_impulse(deflect_direction_vector * strength)
	
	enemy_hittable = true



func spawn_deflect_particles(world_location : Vector2):
	if deflect_particles_scene:
		var deflection_instance = deflect_particles_scene.instantiate()
		get_tree().current_scene.add_child(deflection_instance)
		deflection_instance.global_position = world_location
		
	


func spawn_deflect_nosie():
	if deflect_noise_player_scene:
		var deflect_noise_instance = deflect_noise_player_scene.instantiate()
		get_tree().current_scene.add_child(deflect_noise_instance)
		deflect_noise_instance.global_position = global_position


func _on_raycast_timer_timeout() -> void:
	ray_cast_down.enabled = true
	ray_cast_left.enabled = true
	ray_cast_right.enabled = true
	ray_cast_up.enabled = true
