extends Node2D


@export var delete_after_amount : float = 1.0

@onready var deflect_particles: CPUParticles2D = $DeflectParticles
@onready var self_delete_timer: Timer = $SelfDeleteTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deflect_particles.emitting = true
	self_delete_timer.start(delete_after_amount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_self_delete_timer_timeout() -> void:
	queue_free()
