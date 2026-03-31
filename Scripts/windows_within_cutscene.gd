extends Node2D


@onready var start_timer: Timer = $StartTimer
@onready var end_timer: Timer = $EndTimer

@onready var windows: AnimatedSprite2D = $Windows
@onready var eyes: AnimatedSprite2D = $Eyes
@onready var main_anims: AnimationPlayer = $MainAnims


func _ready() -> void:
	start_timer.start(1)


func _on_start_timer_timeout() -> void:
	windows.play("default")
	eyes.play("default")


func _on_windows_animation_finished() -> void:
	main_anims.play("Main")
	end_timer.start(2)
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Menu Select"):
		get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_four.tscn")


func _on_end_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_four.tscn")
