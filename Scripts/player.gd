extends CharacterBody2D


const SPEED : float = 150.0


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
@onready var roll_1: AudioStreamPlayer2D = $Roll1
@onready var roll_2: AudioStreamPlayer2D = $Roll2
@onready var roll_bubble: AnimatedSprite2D = $RollBubble
@onready var dash_woosh: AnimatedSprite2D = $DashWoosh
@onready var dash_woosh_2: AnimatedSprite2D = $DashWoosh2
@onready var dash_woosh_3: AnimatedSprite2D = $DashWoosh3






var random_roll_picker : int = 1


@onready var interact_label: RichTextLabel = $InteractLabel


@onready var special_timer: Timer = $SpecialTimer
@onready var special_decay_timer: Timer = $SpecialDecayTimer
var special_is_charging : bool = false
var special_is_decaying : bool = false
@export var special_timer_length : float = .2


func _ready() -> void:
	add_to_group("Player")
	GameState.player_alive = true
	GameState.player_is_invul = false
	SignalBus.connect("player_died", on_player_died)
	SignalBus.connect("player_respawn", on_player_respawned)
	SignalBus.connect("player_hit", on_player_hit)
	SignalBus.connect("show_interact_text", show_interact_text)
	SignalBus.connect("hide_interact_text", hide_interact_text)
	SignalBus.connect("start_special_timer", on_special_timer_start)

func get_input():
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	return input.normalized()


func _physics_process(delta: float) -> void:
	
	var player_input = get_input()
	
	if not GameState.is_paused:
		if GameState.player_alive:
			if not is_dashing:
				velocity = lerp(velocity, player_input * SPEED, delta * GameState.current_accel)
			else:
				velocity = dash_direction * SPEED * DASH_POWER * delta
			
		else:
			velocity = Vector2.ZERO
	else:
			velocity = Vector2.ZERO
	
	move_and_slide()


func _process(delta: float) -> void:
	
	
	
	if special_is_charging:
		if GameState.player_special_amount < GameState.MAX_SPECIAL:
			GameState.player_special_amount += GameState.charge_rate
	
		elif  GameState.player_special_amount > GameState.MAX_SPECIAL:
			GameState.player_special_amount = GameState.MAX_SPECIAL
		
	
	elif special_is_decaying:
		if GameState.player_special_amount > GameState.MIN_SPECIAL:
			GameState.player_special_amount -= GameState.charge_rate
		elif GameState.player_special_amount < GameState.MIN_SPECIAL:
			GameState.player_special_amount = GameState.MIN_SPECIAL
	
	
	
	GameState.player_position = global_position
	
	dash_direction = GameState.player_aim_dir.normalized()


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
	roll_bubble.play("default")
	dash_woosh.play("default")
	dash_woosh_2.play("default")
	dash_woosh_3.play("default")
	random_roll_picker = randi_range(1,2)
	if random_roll_picker == 1:
		roll_1.play()
	else:
		roll_2.play()
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
	GameState.player_alive = false
	GameState.is_swinging = false
	$DeathTimer.start()


func _on_death_timer_timeout() -> void:
	SignalBus.emit_signal("player_respawn")

func on_player_respawned():
	GameState.player_alive = true
	GameState.current_player_health = 4
	GameState.player_special_amount = 0

func on_player_hit():
	if not GameState.player_is_invul:
		spawn_blood_splat(global_position)

func spawn_blood_splat(world_location : Vector2):
	if blood_splat_scene:
		var blood_splat_instance = blood_splat_scene.instantiate()
		get_tree().current_scene.call_deferred("add_child", blood_splat_instance)
		blood_splat_instance.global_position = world_location


func show_interact_text():
	interact_label.visible = true

func hide_interact_text():
	interact_label.visible = false


func on_special_timer_start():
	special_is_decaying = false
	special_is_charging = true
	special_timer.start(special_timer_length)

func _on_special_timer_timeout() -> void:
	special_is_charging = false
	special_decay_timer.start()


func _on_special_decay_timer_timeout() -> void:
	if special_timer.is_stopped():
		special_is_decaying = true
