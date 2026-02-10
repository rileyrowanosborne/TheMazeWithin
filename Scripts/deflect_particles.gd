extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("succesful_deflect", on_deflect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_deflect():
	emitting = true
