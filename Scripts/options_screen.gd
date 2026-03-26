extends Node2D


@onready var master: CheckButton = $Master
@onready var sfx: CheckButton = $SFX
@onready var music: CheckButton = $Music



func _ready() -> void:
	master.grab_focus()



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Menu Back"):
		get_tree().change_scene_to_file("res://Scenes/Chapters/Title Screen/title_screen.tscn")
		
	


func _on_master_toggled(toggled_on: bool) -> void:
	GameState.master_volume = toggled_on
	SaveLoad.contents_to_save.master = toggled_on
	SignalBus.emit_signal("audio_update")


func _on_sfx_toggled(toggled_on: bool) -> void:
	GameState.sfx_volume = toggled_on
	SaveLoad.contents_to_save.sfx = toggled_on
	SignalBus.emit_signal("audio_update")



func _on_music_toggled(toggled_on: bool) -> void:
	GameState.music_volume = toggled_on
	SaveLoad.contents_to_save.music = toggled_on
	SignalBus.emit_signal("audio_update")
	
