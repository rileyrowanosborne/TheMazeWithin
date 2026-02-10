extends CharacterBody2D


const SPEED : float = 150.0
const ACCEL : float = 6

var input : Vector2


func _ready() -> void:
	add_to_group("Player")



func get_input():
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	return input.normalized()


func _physics_process(delta: float) -> void:
	
	var player_input = get_input()
	
	
	velocity = lerp(velocity, player_input * SPEED, delta * ACCEL)
	
	
	move_and_slide()


func _process(delta: float) -> void:
	GameState.player_position = global_position
