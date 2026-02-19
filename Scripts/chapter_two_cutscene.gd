extends Node2D



var scene_length : float = 3.0

func _ready() -> void:
	$ChangeSceneTimer.start(scene_length)


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Talk"):
		$MouthAnim.play("Talking")
	
	if event.is_action_pressed("Blink"):
		$EyesAnim.play("Blinking")


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_two.tscn")
