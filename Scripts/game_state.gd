extends Node


var player_position : Vector2

var player_is_invul : bool 

var new_spawn_position : Vector2

var player_alive : bool
var player_health : int

var current_chapter : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_chapter = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
