extends Node2D

@onready var walker_generator: WalkerGenerator = $TilemapGaeaRenderer/WalkerGenerator


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("restart"):
		randomize()
		walker_generator.generate()
