extends CharacterBody2D


const SPEED : float = 150.0
const ACCEL : float = 6

const DASH_POWER : float = 150.0

var input : Vector2

var is_dashing : bool = false
var dash_length : float = .05
var dash_direction : Vector2

var dash_animation_length : float = .5
var is_dash_animation : bool = false

var dash_is_on_cooldown : bool = false
@export var dash_cooldown_length : float = 3.0

var dash_invul_length : float = .5
var is_dash_invul : bool = false

var in_range_of_interactable : bool = false


@export var blood_splat_scene : PackedScene


@onready var interact_label: RichTextLabel = $InteractLabel



func _ready() -> void:
	add_to_group("Player")
	GameState.player_alive = true
	GameState.player_is_invul = false
	SignalBus.connect("player_died", on_player_died)
	SignalBus.connect("player_hit", on_player_hit)
	SignalBus.connect("show_interact_text", show_interact_text)
	SignalBus.connect("hide_interact_text", hide_interact_text)

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
			velocity = dash_direction * SPEED * DASH_POWER * delta
		
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()


func _process(delta: float) -> void:
	
	
	GameState.player_position = global_position
	
	dash_direction = global_position.direction_to(get_global_mouse_position())


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
	
func end_dash_invul():
	GameState.player_is_invul = false
	is_dash_invul = false


func _on_dash_invul_timer_timeout() -> void:
	end_dash_invul()



func on_player_died():
	print("death timer signal recieved")
	GameState.is_swinging = false
	$DeathTimer.start()


func _on_death_timer_timeout() -> void:
	get_tree().call_deferred("reload_current_scene")



func on_player_hit():
	if not GameState.player_is_invul:
		spawn_blood_splat(global_position)

func spawn_blood_splat(world_location : Vector2):
	if blood_splat_scene:
		var blood_splat_instance = blood_splat_scene.instantiate()
		get_tree().current_scene.call_deferred("add_child", blood_splat_instance)
		blood_splat_instance.global_position = world_location




func show_interact_text():
	print("In range yes")
	interact_label.visible = true

func hide_interact_text():
	print("In range no")
	interact_label.visible = false
