extends Camera2D


@export var decay : float = 0.8
@export var max_offset : Vector2 = Vector2(50, 35)
@export var max_roll : float = 0.1



var boss_zoom : Vector2 = Vector2(5,5)
var normal_zoom : Vector2 = Vector2(6,6)

var trauma : float = 0.0
var trauma_power : int = 2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	SignalBus.connect("succesful_deflect", on_succesful_deflect)
	SignalBus.connect("player_hit", on_player_hit)
	SignalBus.connect("enemy_hit", on_enemy_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	
	if GameState.boss_active:
		zoom = boss_zoom
	else:
		zoom = normal_zoom


func add_trauma(amount : float):
	trauma = min(trauma + amount, 1.0)


func shake() -> void: 
	var amoumt = pow(trauma, trauma_power)
	rotation = max_roll * amoumt * randf_range(-1,1)
	offset.x = max_offset.x * amoumt * randf_range(-1,1)
	offset.y  = max_offset.y * amoumt * randf_range(-1,1)



func orm_attack():
	add_trauma(.1)


func on_enemy_hit():
	add_trauma(.2)

func on_succesful_deflect():
	add_trauma(.05)


func on_player_hit():
	if not GameState.player_is_invul:
		add_trauma(.3)
