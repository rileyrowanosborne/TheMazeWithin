extends Node2D



@onready var deflect_noise: AudioStreamPlayer2D = $DeflectNoise
@onready var deflect_noise_2: AudioStreamPlayer2D = $DeflectNoise2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_deflect_noise_finished() -> void:
	queue_free()
