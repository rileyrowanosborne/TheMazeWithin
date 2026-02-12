extends AnimatedSprite2D


var dir : int

var is_moving : bool = false

var is_forward : bool = true

@onready var baseball_bat: Node2D = $"../BaseballBat"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dir == 1:
		flip_h = false
	else:
		flip_h = true
	
	
	
	if Input.is_action_pressed("Down"):
		is_moving = true
		is_forward = true
	
	elif Input.is_action_pressed("Up"):
		is_forward = false
		is_moving = true
		
	elif Input.is_action_pressed("Left")\
	 || Input.is_action_pressed("Right"):
		is_moving = true
	
	else:
		is_moving = false
	
	if GameState.player_alive:
		if not get_parent().is_dash_animation:
			if is_moving and is_forward:
				set_anim("Front Walking")
				baseball_bat.z_index = 4
			
			elif is_moving and not is_forward:
				set_anim("Back Walking")
				baseball_bat.z_index = 3
			
			elif not is_moving and not is_forward:
				set_anim("Back Idle")
				baseball_bat.z_index = 3
			
			elif not is_moving and is_forward:
				set_anim("Front Idle")
				baseball_bat.z_index = 4
		
		else:
			set_anim("Dash")
	else:
		set_anim("Death")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left"):
		dir = -1
	elif event.is_action_pressed("Right"):
		dir = 1



func set_anim(anim : String):
	if animation != anim:
		play(anim)
