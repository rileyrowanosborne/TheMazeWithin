extends Node2D

@onready var change_scene_timer: Timer = $ChangeSceneTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_scene_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_one.tscn")
