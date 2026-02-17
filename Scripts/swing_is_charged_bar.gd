extends TextureProgressBar





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = 5
	min_value = 0
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if value < max_value:
		tint_over.a = 0
		value += 50 * delta
	else:
		tint_over.a = 255


func _input(event: InputEvent) -> void:
	if event.is_action("Swing") and value <= max_value:
		value = 0
