extends Node2D

#timers
@onready var scene_change_timer: Timer = $SceneChangeTimer
@onready var begin_zoom_timer: Timer = $BeginZoomTimer
@onready var skeleton_begin_timer: Timer = $SkeletonBeginTimer
@onready var brain_begin_timer: Timer = $BrainBeginTimer
@onready var mind_palace_begin_timer: Timer = $MindPalaceBeginTimer


#layers
@onready var brain_layer: Node2D = $BrainLayer
@onready var skeleton_layer: Node2D = $SkeletonLayer
@onready var flesh_layer: Node2D = $FleshLayer
@onready var mind_palace_layer: Node2D = $MindPalaceLayer



var scene_length : float = 30.0

var flesh_zooming : bool = false
var skeleton_zooming : bool = false
var brain_zooming : bool = false
var mind_palace_zooming : bool = false



func _ready() -> void:
	begin_zoom_timer.start()


func _process(delta: float) -> void:
	if flesh_zooming:
		flesh_layer.scale += Vector2(1,1) * delta
		if flesh_layer.scale >= Vector2(2.5,2.5):
			flesh_zooming = false
			flesh_layer.visible = false
			skeleton_layer.visible = true
			skeleton_begin_timer.start()
	elif skeleton_zooming:
		skeleton_layer.scale += Vector2(1,1) * delta
		if skeleton_layer.scale >= Vector2(2.5,2.5):
			skeleton_zooming = false
			skeleton_layer.visible = false
			brain_layer.visible = true
			brain_begin_timer.start()
	elif brain_zooming:
		brain_layer.scale += Vector2(2,2) * delta
		if brain_layer.scale >= Vector2(5,5):
			brain_zooming = false
			brain_layer.visible = false
			mind_palace_layer.visible = true
			mind_palace_begin_timer.start()
	elif mind_palace_zooming:
		if mind_palace_layer.scale <= Vector2(10,10):
			mind_palace_layer.scale += Vector2(3,3) * delta
		else:
			mind_palace_layer.scale += Vector2(30,30) * delta
			



func _on_scene_change_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/chapter_four.tscn")


func _on_begin_zoom_timer_timeout() -> void:
	flesh_zooming = true


func _on_brain_begin_timer_timeout() -> void:
	brain_zooming = true


func _on_skeleton_begin_timer_timeout() -> void:
	skeleton_zooming = true


func _on_mind_palace_begin_timer_timeout() -> void:
	mind_palace_zooming = true
