extends Node2D

@onready var cloud_emitter_2: CPUParticles2D = $CloudEmitter2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cloud_emitter_2.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cloud_emitter_2_finished() -> void:
	queue_free()
