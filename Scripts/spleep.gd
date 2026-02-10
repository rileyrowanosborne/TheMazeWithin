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


const SPEED = 1000

var direction_cooldown : bool = false

var d_d_vector : Vector2
var d_d_strenth : float
var is_launched : bool = false


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

func _ready() -> void:
	add_to_group("Enemy")
	direction = direction_choices.pick_random()


func _process(delta: float) -> void:
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
	if not is_launched:
		velocity = SPEED * direction * delta
	else:
		velocity = d_d_vector * d_d_strenth
	
	move_and_slide()
	
	

func _on_cooldown_timer_timeout() -> void:
	direction_cooldown = false



func apply_facing_impulse(strength):
	var player_position = GameState.player_position
	var projectile_position = global_position
	var deflect_direction_vector = (projectile_position - player_position).normalized()
	d_d_vector = deflect_direction_vector
	d_d_strenth = strength
	
	is_launched = true
	


func _on_lauched_timer_timeout() -> void:
	is_launched = false
