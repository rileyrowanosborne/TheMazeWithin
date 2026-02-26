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
@onready var direction_cooldown_timer: Timer = $DirectionCooldownTimer


@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var splotch_sounds: AudioStreamPlayer2D = $SplotchSounds

const SPEED = 35

var direction_cooldown : bool = false

var is_launched : bool = false
var slow_down : bool = false


var bounce_mode : bool

#0,0 means stationary
#1,0 means right
#0,1 means down
var direction = Vector2(0,0)



var is_in_spleep_hole : bool = false



func _ready() -> void:
	add_to_group("Enemy")
	add_to_group("Spleep")
	direction = Vector2(randf_range(-1,1),randf_range(-1,1))


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
				if is_launched and not bounce_mode:
					bounce_mode = true
				else:
					change_direction()
	
	if direction == Vector2.ZERO:
		set_animation("Idle")
	else:
		set_animation("Walking")
	
	
	
func change_direction():
	direction_cooldown = true
	cooldown_timer.start()
	direction = Vector2(randf_range(-1,1),randf_range(-1,1))


func _physics_process(delta: float) -> void:
	if is_in_spleep_hole:
		velocity = Vector2.ZERO
		return
	
	if not is_launched:
		velocity = SPEED * direction
	else:
		if slow_down:
			velocity = lerp(velocity, Vector2.ZERO, 0.1)

	var collision = move_and_collide(velocity * delta)
	
	# Only bounce if launched
	if collision and is_launched:
		velocity = velocity.bounce(collision.get_normal())
		splotch_sounds.pitch_scale = randf_range(1.2, 1.4)
		splotch_sounds.play()
	
	

func _on_cooldown_timer_timeout() -> void:
	direction_cooldown = false



func apply_facing_impulse(strength):
	if not is_in_spleep_hole:
		var player_position = GameState.player_position
		var projectile_position = global_position
		var deflect_direction_vector = (projectile_position - player_position).normalized()
		velocity = deflect_direction_vector * (strength * 1.1)
		lauched_timer.start()
		is_launched = true
		direction = Vector2(0,0)
		direction_cooldown_timer.start()
	



func _on_lauched_timer_timeout() -> void:
	bounce_mode = false
	slow_down_timer.start()
	slow_down = true



func trapped_in_a_hole():
	is_in_spleep_hole = true
	cpu_particles_2d.emitting = true


func _on_slow_down_timer_timeout() -> void:
	is_launched = false
	slow_down = false
	


func set_animation(anim : String):
	if animated_sprite_2d.animation != anim:
		animated_sprite_2d.play(anim)
	
	


func _on_direction_cooldown_timer_timeout() -> void:
	direction = Vector2(randf_range(-1,1),randf_range(-1,1))
	
	if direction == Vector2(0,0):
		direction = Vector2(randf_range(-1,1),randf_range(-1,1))
