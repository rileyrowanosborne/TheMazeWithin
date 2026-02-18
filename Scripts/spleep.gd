extends CharacterBody2D



@onready var ray_cast_down: RayCast2D = $Raycasts/RayCastDown
@onready var ray_cast_down_2: RayCast2D = $Raycasts/RayCastDown2
@onready var ray_cast_up: RayCast2D = $Raycasts/RayCastUp
@onready var ray_cast_up_2: RayCast2D = $Raycasts/RayCastUp2
@onready var ray_cast_right: RayCast2D = $Raycasts/RayCastRight
@onready var ray_cast_right_2: RayCast2D = $Raycasts/RayCastRight2
@onready var ray_cast_left: RayCast2D = $Raycasts/RayCastLeft
@onready var ray_cast_left_2: RayCast2D = $Raycasts/RayCastLeft2

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var lauched_timer: Timer = $LauchedTimer
@onready var slow_down_timer: Timer = $SlowDownTimer


@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D


const SPEED = 50

var direction_cooldown : bool = false

var d_d_vector : Vector2
var d_d_strenth : float
var is_launched : bool = false
var slow_down : bool = false


#0,0 means stationary
#1,0 means right
#0,1 means down
var direction = Vector2(0,0)


var direction_choices = [
	Vector2(1,0), 
	Vector2(-1,0),
	Vector2(0,1),
	Vector2(0,-1),
	Vector2(1,-1), 
]

var is_in_spleep_hole : bool = false



func _ready() -> void:
	add_to_group("Enemy")
	add_to_group("Spleep")
	direction = direction_choices.pick_random()


func _process(delta: float) -> void:
	if not is_in_spleep_hole:
		if not direction_cooldown:
			if ray_cast_down.is_colliding()\
			 or ray_cast_down_2.is_colliding()\
			 or ray_cast_left.is_colliding()\
			 or ray_cast_left_2.is_colliding()\
			or ray_cast_right.is_colliding()\
			or ray_cast_right_2.is_colliding()\
			or ray_cast_up.is_colliding()\
			or ray_cast_up_2.is_colliding():
				is_launched = false
				change_direction()
	
	
	
	
func change_direction():
	direction_cooldown = true
	cooldown_timer.start()
	direction = direction_choices.pick_random()


func _physics_process(delta: float) -> void:
	if not is_in_spleep_hole:
		if not is_launched:
			velocity = SPEED * direction
		else:
			if not slow_down:
				velocity = d_d_vector * d_d_strenth
			else:
				velocity = lerp(velocity, Vector2.ZERO, .1)
		
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	

func _on_cooldown_timer_timeout() -> void:
	direction_cooldown = false



func apply_facing_impulse(strength):
	if not is_in_spleep_hole:
		var player_position = GameState.player_position
		var projectile_position = global_position
		var deflect_direction_vector = (projectile_position - player_position).normalized()
		d_d_vector = deflect_direction_vector
		d_d_strenth = strength
		lauched_timer.start()
		is_launched = true
	


func _on_lauched_timer_timeout() -> void:
	slow_down_timer.start()
	slow_down = true



func trapped_in_a_hole():
	is_in_spleep_hole = true
	cpu_particles_2d.emitting = true


func _on_slow_down_timer_timeout() -> void:
	is_launched = false
	slow_down = false
