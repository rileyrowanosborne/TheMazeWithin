extends Node




var player_is_forward : bool

var cursor_glo_pos : Vector2


var is_paused : bool = false

var player_playing : bool

var player_position : Vector2
var player_is_invul : bool 

var is_swinging: bool
var is_charged : bool
var charging : bool
const MAX_CHARGE : int = 100
const MIN_CHARGE : int = 0
var charge : int 


var new_spawn_position : Vector2

var player_alive : bool
var current_player_health : int

var player_special_amount : int
const MAX_SPECIAL : int = 100
const MIN_SPECIAL : int = 0
var charge_rate : float = 1
var roll_special_cost : int = 25

var current_chapter : int


var current_boss_health : int
var current_floor_boss_max_health : int


var orm_current_phase : int 
var total_boss_enemies : int
var boss_active : int


var chapter_one_door_open : bool
var chapter_two_door_open : bool
var chapter_three_door_open : bool
var chapter_four_door_open : bool


var chapter_one_completed : bool
var chapter_two_completed : bool
var chapter_three_completed : bool
var chapter_four_completed : bool


var current_dialogue : String

var player_aim_dir : Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("succesful_deflect", on_projectile_delfect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and player_playing:
		if is_paused:
			is_paused = false
			SignalBus.emit_signal("unpause_game")
			print("game unpaused")
		else:
			is_paused = true
			SignalBus.emit_signal("pause_game")
			print("game paused")

func on_projectile_delfect():
	SignalBus.emit_signal("start_special_timer")
