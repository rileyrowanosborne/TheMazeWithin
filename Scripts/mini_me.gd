extends CharacterBody2D



@onready var ray_cast_down: RayCast2D = $Raycasts/RayCastDown
@onready var ray_cast_left: RayCast2D = $Raycasts/RayCastLeft
@onready var ray_cast_right: RayCast2D = $Raycasts/RayCastRight
@onready var ray_cast_up: RayCast2D = $Raycasts/RayCastUp


@onready var player_sprites: AnimatedSprite2D = $PlayerSprites
@onready var change_dir_timer: Timer = $ChangeDirTimer

@onready var death_timer: Timer = $DeathTimer


@export var is_player : bool

var input : Vector2
const ACCEL : float = 6
var speed : float = 150

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

var current_direction : Vector2

var player_in_range : bool = false
@export var interactable_type : String


var is_alive : bool = true


func _physics_process(delta: float) -> void:
	
	var player_input = get_input()
	if is_alive:
		if is_player:
			velocity = lerp(velocity, player_input * speed, delta * ACCEL)
		else:
			velocity = current_direction * speed
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()

func _ready() -> void:
	
	add_to_group("Interactable")
	add_to_group(interactable_type)
	
	if not is_player:
		speed = 50
		direction_change()
	else:
		speed = 150


func _process(delta: float) -> void:
	
	
	
	
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
			player_sprites.play("Death")
			death_timer.start(.5)
			current_direction = Vector2(0,0)
			is_alive = false



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
				player_sprites.play("FrontWalk")
			elif sprite_direction == "Back":
				player_sprites.play("BackWalk")
			elif sprite_direction == "Right":
				player_sprites.flip_h = false
				player_sprites.play("SideWalk")
			elif sprite_direction == "Left":
				player_sprites.play("SideWalk")
				player_sprites.flip_h = true
		elif sprite_direction == "Idle":
			if sprite_direction == "Front":
				player_sprites.play("FrontIdle")
			elif sprite_direction == "Back":
				player_sprites.play("BackIdle")
			


func _on_death_timer_timeout() -> void:
	queue_free()
