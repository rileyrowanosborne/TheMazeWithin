extends CharacterBody2D



@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox
@onready var attack_length_timer: Timer = $AttackLengthTimer
@onready var launched_timer: Timer = $LaunchedTimer
@onready var slow_down_timer: Timer = $SlowDownTimer


@export var left_or_right : bool

var attack_velocity : int = 200

var is_attacking : bool = false
var returning_to_orm = false
var direction_to_player : Vector2
var direction_to_orm : Vector2
var attack_length : float = 1.0






var d_d_vector : Vector2
var d_d_strenth : float
var is_launched : bool = false
var slow_down : bool = false


func _ready() -> void:
	add_to_group("Orm Head")
	animated_sprite_2d.flip_h = left_or_right


func _physics_process(delta: float) -> void:
	if is_launched:
		if slow_down:
			velocity = lerp(velocity, Vector2.ZERO, .1)
		else:
			velocity = d_d_vector * d_d_strenth 
			is_attacking = false
	else:
		if is_attacking:
			velocity = direction_to_player * attack_velocity
			hitbox.monitoring = true
		else:
			hitbox.monitoring = false
	
	move_and_slide()
	

func begin_attack():
	print("head attacking")
	is_attacking = true
	direction_to_player = global_position.direction_to(GameState.player_position)
	attack_length_timer.start(attack_length)


func _on_attack_length_timer_timeout() -> void:
	is_attacking = false


func apply_facing_impulse(strength):
	var player_position = GameState.player_position
	var projectile_position = global_position
	var deflect_direction_vector = (projectile_position - player_position).normalized()
	d_d_vector = deflect_direction_vector
	d_d_strenth = strength
	launched_timer.start()
	is_launched = true


func _on_slow_down_timer_timeout() -> void:
	is_launched = false
	slow_down = false


func _on_launched_timer_timeout() -> void:
	slow_down_timer.start()
	slow_down = true
