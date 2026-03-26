extends Node

var master_bus_index = AudioServer.get_bus_index("Master")
var sfx_bus_index = AudioServer.get_bus_index("SFX")
var music_bus_index = AudioServer.get_bus_index("Music")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_bus_index = AudioServer.get_bus_index("Master")
	sfx_bus_index = AudioServer.get_bus_index("SFX")
	music_bus_index = AudioServer.get_bus_index("Music")
	
	SignalBus.connect("audio_update", on_update_recieved)


func on_update_recieved():
	
	print("audio update fired")
	print(GameState.master_volume, GameState.sfx_volume, GameState.music_volume)
	
	
	AudioServer.set_bus_mute(master_bus_index, GameState.master_volume)
	AudioServer.set_bus_mute(sfx_bus_index, GameState.sfx_volume)
	AudioServer.set_bus_mute(music_bus_index, GameState.music_volume)
