extends AudioStreamPlayer2D



@onready var timer: Timer = $Timer


@export var timer_delay : int = 60
@export var starting_delay : int 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_delay = randf_range(0,starting_delay)
	
	timer.start(timer_delay)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	play()
	timer_delay = randf_range(60,120)
	timer.start(timer_delay)
