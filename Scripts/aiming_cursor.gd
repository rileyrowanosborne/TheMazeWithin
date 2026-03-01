extends Node2D



const MIN_DIST = 0.0
const MAX_DIST = 10.0

var aim_direction : Vector2 = Vector2.ZERO
const JOY_DEADZONE = 0.2

@onready var aim_line: Line2D = $AimLine



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	aim_direction = Input.get_vector("Aim Left","Aim Right","Aim Up", "Aim Down", JOY_DEADZONE)
	

	
	if aim_direction.length() > JOY_DEADZONE:
		rotation = aim_direction.angle()
		
		
	
	
	if aim_direction < Vector2.ZERO:
		if aim_line.position.x < MAX_DIST:
			aim_line.position.x = MAX_DIST
			aim_line.position.x += 50.0 * delta
		
	else:
		if aim_line.position.x > MIN_DIST:
			aim_line.position.x = MIN_DIST
			aim_line.position.x -= 50.0 * delta
