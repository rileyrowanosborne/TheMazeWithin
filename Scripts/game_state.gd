extends Node


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
var player_health : int

var player_special_amount : int
const MAX_SPECIAL : int = 100
const MIN_SPECIAL : int = 0
var roll_special_cost : int = 25

var current_chapter : int


var current_boss_health : int
var current_floor_boss_max_health : int


var orm_current_phase : int 
var total_boss_enemies : int
var boss_active : int



var current_dialogue : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("succesful_deflect", on_projectile_delfect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func on_projectile_delfect():
	if player_special_amount < MAX_SPECIAL:
		player_special_amount += 10
