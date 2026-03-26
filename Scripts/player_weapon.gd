extends Node2D


@onready var swing_timer: Timer = $SwingTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var slash_anim: AnimatedSprite2D = $SlashAnim
@onready var swing_is_charged_particles: CPUParticles2D = $SwingIsChargedParticles

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var woosh: AudioStreamPlayer2D = $Woosh




@onready var swing_hit_box: Area2D = $SwingHitBox


const BASE_BALL_BAT_ANIMS = preload("uid://cd0wxsngxaaxb")
const GOLF_CLUB_ANIMS = preload("uid://dte7sk6w3d1e6")
const SWORD_ANIMS = preload("uid://dtjo6jx3mrfmi")
const PENCIL_ANIMS = preload("uid://ds3rn40e3c4r3")
const SPOON_ANIMS = preload("uid://trppv1gqnl42")



var weapon_anim


var aim_direction : Vector2 = Vector2.ZERO
const JOY_DEADZONE = 0.2







var is_swinging: bool
var is_charged : bool
var charging : bool
const MAX_CHARGE : int = 100
const MIN_CHARGE : int = 0
var charge : int = 0
@export var charge_rate : int = 200

var on_cooldown : bool = false


func _ready() -> void:
	if SaveLoad.contents_to_save.current_weapon == GameState.weapon_types.golf_club:
		sprite_2d.sprite_frames = GOLF_CLUB_ANIMS
	elif SaveLoad.contents_to_save.current_weapon == GameState.weapon_types.baseball_bat:
		sprite_2d.sprite_frames = BASE_BALL_BAT_ANIMS
	elif SaveLoad.contents_to_save.current_weapon == GameState.weapon_types.sword:
		sprite_2d.sprite_frames = SWORD_ANIMS
	elif SaveLoad.contents_to_save.current_weapon == GameState.weapon_types.pencil:
		sprite_2d.sprite_frames = PENCIL_ANIMS
	elif SaveLoad.contents_to_save.current_weapon== GameState.weapon_types.spoon:
		sprite_2d.sprite_frames = SPOON_ANIMS
	
	
	SignalBus.connect("player_died", on_player_died)
	SignalBus.connect("player_respawn", player_respawned)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if GameState.player_is_forward:
		z_index = 4
	else:
		z_index = 3
	
	
	if slash_anim.is_playing():
		swing_hit_box.monitoring = true
	else:
		swing_hit_box.monitoring = false
	
	
	if charging and charge <= MAX_CHARGE:
			charge += charge_rate * delta
		
	if charge >= MAX_CHARGE:
		swing_is_charged_particles.emitting = true
		sprite_2d.play("Charged")
		charge = MAX_CHARGE
		is_charged = true
		charging = false
		on_cooldown = true
			
			
		
	aim_direction = Input.get_vector("Aim Left","Aim Right","Aim Up", "Aim Down", JOY_DEADZONE)
	

	
	if aim_direction.length() > JOY_DEADZONE:
		rotation = aim_direction.angle()
		GameState.player_aim_dir = aim_direction
		
	
	if aim_direction != Vector2(0,0):
		charging = true
		$SwingHitBox/Cursor.visible = true
	
	else:
		swing()
		$SwingHitBox/Cursor.visible = false


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Swing"):
		charging = true
		
		if not is_charged:
			sprite_2d.play("Charging")
		
	
	
	if Input.is_action_just_released("Swing"):
		swing()


func _on_swing_timer_timeout() -> void:
	GameState.is_swinging = false

func swing():
	sprite_2d.play("Idle")
	charge = MIN_CHARGE
	charging = false
	if is_charged:
		woosh.play()

		is_charged = false
		GameState.is_swinging = true
		animation_player.play("Swing")
		slash_anim.play("Swing")
		swing_timer.start()

func on_player_died():
	visible = false


func player_respawned():
	visible = true
