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


var is_enemy_hittable : bool = false






func _ready() -> void:
	add_to_group("Projectile")
	

	

func _process(delta: float) -> void:
	
	if ray_cast_down.is_colliding()\
	|| ray_cast_left.is_colliding()\
	|| ray_cast_right.is_colliding()\
	|| ray_cast_up.is_colliding():
		queue_free()
	
	if GameState.player_is_invul:
		$HitBox.set_collision_mask_value(1,false)
		ray_cast_down.set_collision_mask_value(1,false)
		ray_cast_left.set_collision_mask_value(1,false)
		ray_cast_right.set_collision_mask_value(1,false)
		ray_cast_up.set_collision_mask_value(1,false)
	else:
		$HitBox.set_collision_mask_value(1,true)
		ray_cast_down.set_collision_mask_value(1,true)
		ray_cast_left.set_collision_mask_value(1,true)
		ray_cast_right.set_collision_mask_value(1,true)
		ray_cast_up.set_collision_mask_value(1,true)

func _on_hit_box_body_entered(body: Node2D) -> void:
	if is_enemy_hittable:
		if body.is_in_group("Enemy"):
			if body.has_method("take_damage"):
				body.take_damage()
				queue_free()
		

func apply_facing_impulse(strength):
	spawn_delfect_particles(global_position)
	var mouse_position = get_global_mouse_position()
	var projectile_position = global_position
	var deflect_direction_vector = (mouse_position - projectile_position).normalized()
	
	apply_central_impulse(deflect_direction_vector * strength)
	
	is_enemy_hittable = true


func spawn_delfect_particles(world_location : Vector2):
	if delfect_particles_scene:
		var deflection_instance = delfect_particles_scene.instantiate()
		add_child(deflection_instance)
		deflection_instance.global_position = world_location
		
	
