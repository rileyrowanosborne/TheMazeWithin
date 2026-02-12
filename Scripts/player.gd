extends CharacterBody2D


const SPEED : float = 150.0
const ACCEL : float = 6

const DASH_POWER : float = 500.0

var input : Vector2

var is_dashing : bool = false
var dash_length : float = .05

var dash_animation_length : float = .5
var is_dash_animation : bool = false

var dash_is_on_cooldown : bool = false
var dash_cooldown_length : float = 3.0

var dash_invul_length : float = .5
var is_dash_invul : bool = false



func _ready() -> void:
	add_to_group("Player")
	GameState.player_alive = true
	SignalBus.connect("player_died", on_player_died)
	$HurtBox.set_collision_layer_value(1,true)



func get_input():
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	return input.normalized()


func _physics_process(delta: float) -> void:
	
	var player_input = get_input()
	
	if GameState.player_alive:
		if not is_dashing:
			velocity = lerp(velocity, player_input * SPEED, delta * ACCEL)
		else:
			velocity = (get_global_mouse_position() - global_position) * DASH_POWER * delta
		
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()


func _process(delta: float) -> void:
	GameState.player_position = global_position



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Dash") and not dash_is_on_cooldown:
		start_dash_invul()
		dash()


func _on_dash_timer_timeout() -> void:
	is_dashing = false
	


func _on_dash_cooldown_timeout() -> void:
	dash_is_on_cooldown = false


func _on_dash_animation_timer_timeout() -> void:
	is_dash_animation = false


func dash():
	is_dash_animation = true
	$DashAnimationTimer.start(dash_animation_length)
	is_dashing = true
	dash_is_on_cooldown = true
	$DashTimer.start(dash_length)
	$DashCooldown.start(dash_cooldown_length)


func start_dash_invul():
	GameState.player_is_invul = true
	is_dash_invul = true
	$DashInvulTimer.start(dash_invul_length)
	set_collision_mask_value(2,false)
	set_collision_mask_value(4,false)
	set_collision_mask_value(5,false)
	
func end_dash_invul():
	GameState.player_is_invul = false
	is_dash_invul = false
	set_collision_mask_value(2,true)
	set_collision_mask_value(4,true)
	set_collision_mask_value(5,true)


func _on_dash_invul_timer_timeout() -> void:
	end_dash_invul()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Projectile"):
		if GameState.player_is_invul:
			print("Dodged")
		else:
			SignalBus.emit_signal("player_hit")
			body.queue_free()


func on_player_died():
	print("death timer signal recieved")
	$DeathTimer.start()


func _on_death_timer_timeout() -> void:
	get_tree().call_deferred("reload_current_scene")
