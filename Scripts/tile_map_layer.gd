extends TileMapLayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("room_generated", on_room_generated)
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func player_in_wall():
	pass
	#get_tree().reload_current_scene()


func on_room_generated():
	pass
