extends CharacterBody2D



@onready var ray_cast_down: RayCast2D = $Raycasts/RayCastDown
@onready var ray_cast_left: RayCast2D = $Raycasts/RayCastLeft
@onready var ray_cast_right: RayCast2D = $Raycasts/RayCastRight
@onready var ray_cast_up: RayCast2D = $Raycasts/RayCastUp


@onready var player_sprites: AnimatedSprite2D = $PlayerSprites



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

const SPEED : int = 50


var is_alive : bool = true


func _physics_process(delta: float) -> void:
	
	velocity = current_direction * SPEED
	
	move_and_slide()

func _ready() -> void:
	direction_change()
	


func _process(delta: float) -> void:
	
	if ray_cast_down.is_colliding()\
	or ray_cast_left.is_colliding()\
	or ray_cast_right.is_colliding()\
	or ray_cast_up.is_colliding():
		direction_change()
		
	
	



func direction_change():
	current_direction.x = randf_range(-1,1)
	current_direction.y = randf_range(-1,1)
	
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
	elif sprite_state == "Dead":
		player_sprites.play("Death")
		current_direction = Vector2(0,0)


func _on_death_timer_timeout() -> void:
	sprite_state = "Dead"
