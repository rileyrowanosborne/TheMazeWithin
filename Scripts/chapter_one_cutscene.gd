extends Node2D


var text_progress : int = 0

var scene_length : float = 7.0

@onready var text_timer: Timer = $TextTimer
@onready var change_scene_timer: Timer = $ChangeSceneTimer
@onready var eyes_anim: AnimatedSprite2D = $EyesAnim
@onready var mouth_anim: AnimatedSprite2D = $MouthAnim



@onready var i_text: RichTextLabel = $CutsceneText/IText
@onready var am_text: RichTextLabel = $CutsceneText/AmText
@onready var everyone_text: RichTextLabel = $CutsceneText/EveryoneText
@onready var i_text_2: RichTextLabel = $CutsceneText/IText2
@onready var have_text: RichTextLabel = $CutsceneText/HaveText
@onready var ever_text: RichTextLabel = $CutsceneText/EverText
@onready var loved_text: RichTextLabel = $CutsceneText/LovedText




func _ready() -> void:
	change_scene_timer.start(scene_length)
	text_timer.start()


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Talk"):
		mouth_anim.play("Talking")
	
	if event.is_action_pressed("Blink"):
		eyes_anim.play("Blinking")


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_four.tscn")


func _on_text_timer_timeout() -> void:
	text_progress += 1
	text_progress_check()
	if text_progress < 7:
		text_timer.start()


func text_progress_check():
	if text_progress == 1:
		i_text.visible = true
	elif text_progress == 2:
		am_text.visible = true
	elif text_progress == 3:
		everyone_text.visible = true
	elif text_progress == 4:
		i_text_2.visible = true
	elif text_progress == 5:
		have_text.visible = true
	elif text_progress == 6:
		ever_text.visible = true
	elif text_progress == 7:
		loved_text.visible = true
