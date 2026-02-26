extends Area2D


@onready var door: AnimatedSprite2D = $Door


@export var chapter : int

var in_range : bool


func _ready() -> void:
	SignalBus.connect("open_door", on_door_opened)
	
	
	in_range = false



func _process(delta: float) -> void:
	if chapter == 1 and GameState.chapter_one_door_open:
		set_animation("Open")
	elif chapter == 2 and GameState.chapter_two_door_open:
		set_animation("Open")
	elif chapter == 3 and GameState.chapter_three_door_open:
		set_animation("Open")
	elif chapter == 4 and GameState.chapter_four_door_open:
		set_animation("Open")
	else:
		set_animation("Closed")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range = false



func set_animation(anim : String):
	if door.animation != anim:
		door.play(anim)



func on_door_opened():
	pass
