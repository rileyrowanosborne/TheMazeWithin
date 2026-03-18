extends Node2D



@export var current_level : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.current_chapter = current_level
