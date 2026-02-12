extends RigidBody2D
class_name projectile

var dir : Vector2
var speed : float = 100.0

@export var delfect_particles_scene : PackedScene


@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

@onready var sprite_2d: Sprite2D = $Sprite2D


var enemy_hittable : bool = false






func _ready() -> void:
	add_to_group("Projectile")
	

	

func _process(delta: float) -> void:
	if ray_cast_down.is_colliding()\
	|| ray_cast_left.is_colliding()\
	|| ray_cast_right.is_colliding()\
	|| ray_cast_up.is_colliding():
		queue_free()
	




func apply_facing_impulse(strength):
	spawn_delfect_particles(global_position)
	var mouse_position = get_global_mouse_position()
	var projectile_position = global_position
	var deflect_direction_vector = (mouse_position - projectile_position).normalized()
	
	apply_central_impulse(deflect_direction_vector * strength)
	
	enemy_hittable = true


func spawn_delfect_particles(world_location : Vector2):
	if delfect_particles_scene:
		var deflection_instance = delfect_particles_scene.instantiate()
		add_child(deflection_instance)
		deflection_instance.global_position = world_location
		
	
