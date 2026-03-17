extends Sprite2D



var last_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GameState.cursor_glo_pos


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Aim Down")\
	or event.is_action_pressed("Aim Right")\
	or Input.is_action_pressed("Aim Up")\
	or Input.is_action_pressed("Aim Left"):
		GameState.cursor_glo_pos = global_position
