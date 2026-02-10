extends Node2D


@export var player_scene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("room_generated", on_room_generated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_room_generated():
	
	spawn_player(GameState.new_spawn_position)
	

func spawn_player(spawn_point : Vector2):
	if player_scene:
		var player_instance = player_scene.instantiate()
		add_child(player_instance)
		player_instance.global_position = spawn_point
		
