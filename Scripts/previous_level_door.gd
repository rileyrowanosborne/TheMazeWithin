extends Area2D


@onready var enter_text: RichTextLabel = $EnterText
@onready var door: AnimatedSprite2D = $Door


@export var chapter : int

var in_range : bool 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_animation("Open")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range = true
		enter_text.visible = true
		
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range = false
		enter_text.visible = false


func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and in_range:
		if chapter == 2:
			get_tree().change_scene_to_file("res://Scenes/Chapters/Completed Chapters/completed_chapter_one.tscn")
		elif chapter == 3:
			get_tree().change_scene_to_file("res://Scenes/Chapters/Completed Chapters/completed_chapter_two.tscn")
		elif chapter == 4:
			get_tree().change_scene_to_file("res://Scenes/Chapters/Completed Chapters/completed_chapter_three.tscn")



func set_animation(anim : String):
	if door.animation != anim:
		door.play(anim)
