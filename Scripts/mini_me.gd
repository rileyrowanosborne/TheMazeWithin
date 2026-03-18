extends CharacterBody2D

@onready var audio_listener_2d: AudioListener2D = $AudioListener2D


@onready var ray_cast_down: RayCast2D = $Raycasts/RayCastDown
@onready var ray_cast_left: RayCast2D = $Raycasts/RayCastLeft
@onready var ray_cast_right: RayCast2D = $Raycasts/RayCastRight
@onready var ray_cast_up: RayCast2D = $Raycasts/RayCastUp


@onready var player_sprites: AnimatedSprite2D = $PlayerSprites
@onready var change_dir_timer: Timer = $ChangeDirTimer

@onready var death_timer: Timer = $DeathTimer
@onready var munch: AudioStreamPlayer2D = $Munch


@onready var launched_timer: Timer = $LaunchedTimer
@onready var slow_down_timer: Timer = $SlowDownTimer







@export var health : int = 4


@export var is_player : bool

var input : Vector2
const ACCEL : float = .1
var speed : float 

var sprite_direction = [
	"Front",
	"Back",
	"Left",
	"Right"
]

var sprite_state = [
	"Idle",
	"Walking",
	"Dead",
	
]


var dir

var is_moving : bool
var is_forward : bool


var current_direction : Vector2

var player_in_range : bool = false
@export var interactable_type : String


var is_alive : bool = true

var last_dir : Vector2



var is_launched : bool
var slow_down : bool
var is_bouncing : bool = false



func _ready() -> void:
	
	add_to_group("Interactable")
	add_to_group(interactable_type)
	
	if not is_player:
		speed = 50
		direction_change()
		audio_listener_2d.clear_current()
	else:
		speed = 150
		audio_listener_2d.make_current()




func _physics_process(delta: float) -> void:
	
	
	
	var player_input = get_input()
	if is_alive:
			if is_player:
				if not is_launched:
					velocity = lerp(velocity, player_input * speed, ACCEL)
				else:
					if slow_down:
						velocity = lerp(velocity, Vector2.ZERO, 0.1)
			else:
				velocity = current_direction * speed
		
	else:
		velocity = Vector2.ZERO
			
	
	move_and_slide()
	
	
	if is_bouncing:
		var collision = get_last_slide_collision()
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			velocity *= 0.9

func apply_facing_impulse(saw_position, strength):
	var deflect_direction_vector = (global_position - saw_position).normalized()
	velocity = deflect_direction_vector * (strength * 1.1)
	is_bouncing = true
	launched_timer.start()
	is_launched = true
	


func take_damage(saw_position):
	print("Youch!")
	apply_facing_impulse(saw_position, 2000)


func _process(delta: float) -> void:
	
	
	

	
	if is_player:
		
		if dir == 1:
			player_sprites.flip_h = false
		else:
			player_sprites.flip_h = true
		
		
		if Input.is_action_pressed("Down"):
			is_moving = true
			is_forward = true
			
		
		elif Input.is_action_pressed("Up"):
			is_forward = false
			is_moving = true
			
		elif Input.is_action_pressed("Left")\
		 || Input.is_action_pressed("Right"):
			is_moving = true
			
		
		else:
			is_moving = false
		
		
		#if GameState.is_paused:
			#set_anim("Front Idle")
		#else:
			#if is_moving and is_forward:
				#set_anim("Front Walking")
			#
			#elif is_moving and not is_forward:
				#set_anim("Back Walking")
			#
			#elif not is_moving and not is_forward:
				#set_anim("Back Idle")
			#
			#elif not is_moving and is_forward:
				#set_anim("Front Idle")

		
		
		
		
		
		
		
	
		if input == Vector2.ZERO:

			if is_forward:
				player_sprites.play("Front Idle")
			else:
				player_sprites.play("Back Idle")
		else:
			if is_moving and is_forward:
				player_sprites.play("Front Walking")
			elif is_moving and not is_forward:
				player_sprites.play("Back Walking")
				
	
	
	
	if not is_player:
		if change_dir_timer.is_stopped():
			if ray_cast_down.is_colliding()\
			or ray_cast_left.is_colliding()\
			or ray_cast_right.is_colliding()\
			or ray_cast_up.is_colliding():
				change_dir_timer.start()
				direction_change()
			


func _input(event: InputEvent) -> void:
	if player_in_range:
		if event.is_action_pressed("Interact"):
			munch.play()
			if GameState.current_player_health < 4:
				GameState.current_player_health += 1
			SignalBus.emit_signal("update_health")
			player_sprites.play("Death")
			death_timer.start(.5)
			current_direction = Vector2(0,0)
			is_alive = false
	
	if event.is_action_pressed("Left"):
		dir = -1
	elif event.is_action_pressed("Right"):
		dir = 1
	

func get_input():
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	return input.normalized()



func direction_change():
	if not is_player:
		current_direction.x = randf_range(-1,1)
		current_direction.y = randf_range(-1,1)
	

	if is_alive:
		if current_direction.x < 0:
			sprite_direction = "Right"
		elif current_direction.x > 0:
			sprite_direction = "Left"
		
		if current_direction.y < 1:
			sprite_direction = "Front"
		elif current_direction.y > 1:
			sprite_direction = "Back"
		
		if current_direction == Vector2(0,0):
			sprite_state = "Idle"
		else:
			sprite_state = "Walking"
	
	
		if sprite_state == "Walking":
			if sprite_direction == "Front":
				player_sprites.play("Front Walking")
			elif sprite_direction == "Back":
				player_sprites.play("Back Walking")
			elif sprite_direction == "Right":
				player_sprites.flip_h = false
				player_sprites.play("Side Walk")
			elif sprite_direction == "Left":
				player_sprites.play("Side Walk")
				player_sprites.flip_h = true
		elif sprite_direction == "Idle":
			if sprite_direction == "Front":
				player_sprites.play("Front Idle")
			elif sprite_direction == "Back":
				player_sprites.play("Back Idle")
			



func set_anim(anim : String):
	if player_sprites.animation != anim:
		player_sprites.play(anim)









func _on_death_timer_timeout() -> void:
	queue_free()


func _on_launched_timer_timeout() -> void:
	is_bouncing = false
	slow_down_timer.start()
	slow_down = true


func _on_slow_down_timer_timeout() -> void:
	is_launched = false
	slow_down = false
