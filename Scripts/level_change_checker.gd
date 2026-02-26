extends Area2D


@onready var door: AnimatedSprite2D = $Door
@onready var enter_text: RichTextLabel = $EnterText



@export var chapter : int
@export var floor_completed : bool 

var in_range : bool


func _ready() -> void:
	SignalBus.connect("open_door", on_door_opened)
	
	
	in_range = false



func _process(delta: float) -> void:
	if chapter == 1 and GameState.chapter_one_door_open:
		set_animation("Open")
		if in_range:
			enter_text.visible = true
	elif chapter == 2 and GameState.chapter_two_door_open:
		set_animation("Open")
		if in_range:
			enter_text.visible = true
	elif chapter == 3 and GameState.chapter_three_door_open:
		set_animation("Open")
		if in_range:
			enter_text.visible = true
	elif chapter == 4 and GameState.chapter_four_door_open:
		set_animation("Open")
		if in_range:
			enter_text.visible = true
	else:
		if floor_completed:
			set_animation("Open")
			if in_range:
				enter_text.visible = true
		else:
			set_animation("Closed")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range = true
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range = false
		enter_text.visible = false


func set_animation(anim : String):
	if door.animation != anim:
		door.play(anim)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and in_range:
		
		if chapter == 1:
			if GameState.chapter_two_completed:
				get_tree().change_scene_to_file("res://Scenes/Chapters/Completed Chapters/completed_chapter_two.tscn")
			else:
				if floor_completed:
					get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_two.tscn")
				else:
					get_tree().change_scene_to_file("res://Scenes/Chapters/Chapter Interludes/chapter_screen.tscn")
					GameState.current_chapter += 1
		elif chapter == 2:
			if GameState.chapter_three_completed:
				get_tree().change_scene_to_file("res://Scenes/Chapters/Completed Chapters/completed_chapter_three.tscn")
			else:
				if floor_completed:
					get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_three.tscn")
				else:
					get_tree().change_scene_to_file("res://Scenes/Chapters/Chapter Interludes/chapter_screen.tscn")
					GameState.current_chapter += 1
		elif chapter == 3:
			if GameState.chapter_four_completed:
				get_tree().change_scene_to_file("res://Scenes/Chapters/Completed Chapters/completed_chapter_four.tscn")
			else:
				if floor_completed:
					get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_four.tscn")
				else:
					get_tree().change_scene_to_file("res://Scenes/Chapters/Chapter Interludes/chapter_screen.tscn")
					GameState.current_chapter += 1




func on_door_opened():
	pass
