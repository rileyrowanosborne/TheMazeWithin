extends Camera2D


@export var decay : float = 0.8
@export var max_offset : Vector2 = Vector2(50, 35)
@export var max_roll : float = 0.1



@export var boss_zoom : Vector2 = Vector2(3,3)
@export var normal_zoom : Vector2 = Vector2(4,4)

var trauma : float = 0.0
var trauma_power : int = 2

@onready var trauma_cooldown: Timer = $TraumaCooldown


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
	
	
	if GameState.museum_active:
		zoom = Vector2(3,3)
	
	else:
		if GameState.boss_active:
			zoom = zoom.move_toward(boss_zoom, 0.05)
		else:
			zoom = zoom.move_toward(normal_zoom, 0.05)
		



func add_trauma(amount : float):
	trauma = min(trauma + amount, 1.0)
	trauma_cooldown.start()


func shake() -> void: 
	var amoumt = pow(trauma, trauma_power)
	rotation = max_roll * amoumt * randf_range(-1,1)
	offset.x = max_offset.x * amoumt * randf_range(-1,1)
	offset.y  = max_offset.y * amoumt * randf_range(-1,1)



func orm_attack():
	if trauma_cooldown.is_stopped():
		add_trauma(.3)


func on_enemy_hit():
	if trauma_cooldown.is_stopped():
		add_trauma(.4)

func on_succesful_deflect():
	if trauma_cooldown.is_stopped():
		add_trauma(.4)
	


func on_player_hit():
	if not GameState.player_is_invul:
		if trauma_cooldown.is_stopped():
			add_trauma(.5)
