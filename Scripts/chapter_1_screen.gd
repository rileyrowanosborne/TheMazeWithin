extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TheBoyTimer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/chapter_one.tscn")


func _on_the_boy_timer_timeout() -> void:
	$RichTextLabel.text = "THE CHILD"
	$ChangeSceneTimer.start()
