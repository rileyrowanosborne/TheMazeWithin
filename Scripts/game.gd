extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("player_died", on_player_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_player_died():
	get_tree().call_deferred("reload_current_scene")
