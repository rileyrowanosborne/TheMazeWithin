extends Timer


@export var timer_length : float



const MIN_CHARGE = 0
const MAX_CHARGE = 100

var is_charging : bool
var is_charged : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("start_special_timer", on_special_timer_start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_charging:
		if GameState.player_special_amount < GameState.MAX_SPECIAL:
			GameState.player_special_amount += GameState.charge_rate
	
		elif  GameState.player_special_amount > GameState.MAX_SPECIAL:
			GameState.player_special_amount = GameState.MAX_SPECIAL


func on_special_timer_start():
	is_charging = true
	start(timer_length)
	
	




func _on_timeout() -> void:
	is_charging = false
