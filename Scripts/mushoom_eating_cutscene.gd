extends Node2D




@onready var eyes: AnimatedSprite2D = $Eyes
@onready var main_text: RichTextLabel = $MainText
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var end_timer: Timer = $EndTimer
@onready var square_timer: Timer = $SquareTimer


func _ready() -> void:
	SignalBus.connect("start_mushroom_cutscene", start_cutscene)


func start_cutscene():
	visible = true
	eyes.play("default")

func _on_eyes_animation_finished() -> void:
	main_text.visible = true
	square_timer.start(1)
	


func _on_end_timer_timeout() -> void:
	SignalBus.emit_signal("show_dialogue")
	queue_free()
	
	


func _on_square_timer_timeout() -> void:
	animation_player.play("Main")
	end_timer.start(4)
