extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if GameState.current_chapter == 1:
		$RichTextLabel.text = "CHAPTER I"
	elif GameState.current_chapter == 2:
		$RichTextLabel.text = "CHAPTER II"
	elif GameState.current_chapter == 3:
		$RichTextLabel.text = "CHAPTER III"
	elif GameState.current_chapter == 4:
		$RichTextLabel.text = "CHAPTER IV"
	$TheBoyTimer.start()
	



func _on_change_scene_timer_timeout() -> void:
	if GameState.current_chapter == 1:
		get_tree().change_scene_to_file("res://Scenes/chapter_four_cutscene.tscn")
	
	elif GameState.current_chapter == 2:
		get_tree().change_scene_to_file("res://Scenes/chapter_two_cutscene.tscn")
		
	elif  GameState.current_chapter == 3:
		get_tree().change_scene_to_file("res://Scenes/chapter_three_cutscene.tscn")
	
	elif  GameState.current_chapter == 4:
		get_tree().change_scene_to_file("res://Scenes/chapter_one_cutscene.tscn")
	


func _on_the_boy_timer_timeout() -> void:
	
	if GameState.current_chapter == 1:
		$RichTextLabel.text = "THE CHILD"
		$ChangeSceneTimer.start()
		
	elif GameState.current_chapter == 2:
		$RichTextLabel.text = "HIS FAVORITE"
		$ChangeSceneTimer.start()
		
	elif GameState.current_chapter == 3:
		$RichTextLabel.text = "HIS PAST"
		$ChangeSceneTimer.start()
		
	elif GameState.current_chapter == 4:
		$RichTextLabel.text = "HIS FUTURE"
		$ChangeSceneTimer.start()
