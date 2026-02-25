extends Node2D


@onready var swing_timer: Timer = $SwingTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var slash_anim: AnimatedSprite2D = $SlashAnim
@onready var swing_is_charged_particles: CPUParticles2D = $"../ChargeUI/SwingIsChargedParticles"
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D


@onready var swing_hit_box: Area2D = $SwingHitBox


const BASE_BALL_BAT_ANIMS = preload("uid://cd0wxsngxaaxb")
const GOLF_CLUB_ANIMS = preload("uid://dte7sk6w3d1e6")
const SWORD_ANIMS = preload("uid://dtjo6jx3mrfmi")



var weapon_anim


enum weapon_types {
	golf_club,
	baseball_bat,
	sword,
	
}

@export var current_weapon : weapon_types


var is_swinging: bool
var is_charged : bool
var charging : bool
const MAX_CHARGE : int = 100
const MIN_CHARGE : int = 0
var charge : int = 0
@export var charge_rate : int = 200

var on_cooldown : bool = false


func _ready() -> void:
	if current_weapon == weapon_types.golf_club:
		sprite_2d.sprite_frames = GOLF_CLUB_ANIMS
	if current_weapon == weapon_types.baseball_bat:
		sprite_2d.sprite_frames = BASE_BALL_BAT_ANIMS
	if current_weapon == weapon_types.sword:
		sprite_2d.sprite_frames = SWORD_ANIMS
	
	SignalBus.connect("player_died", on_player_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if slash_anim.is_playing():
		swing_hit_box.monitoring = true
	else:
		swing_hit_box.monitoring = false
	
	
	if charging and charge <= MAX_CHARGE:
			charge += charge_rate * delta
		
	if charge >= MAX_CHARGE:
		sprite_2d.play("Charged")
		charge = MAX_CHARGE
		is_charged = true
		charging = false
		on_cooldown = true
			
			
		
	
	


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Swing"):
		charging = true
		
		if not is_charged:
			sprite_2d.play("Charging")
		
	
	
	if Input.is_action_just_released("Swing"):
		sprite_2d.play("Idle")
		charge = MIN_CHARGE
		charging = false
		if is_charged:
			is_charged = false
			GameState.is_swinging = true
			animation_player.play("Swing")
			slash_anim.play("Swing")
			swing_timer.start()


func _on_swing_timer_timeout() -> void:
	swing_is_charged_particles.emitting = true
	GameState.is_swinging = false



func on_player_died():
	visible = false
