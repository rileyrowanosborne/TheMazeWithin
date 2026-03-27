extends AudioStreamPlayer2D




const FREQUENTLY_ETHEREAL = preload("uid://d3xv7aeh28xgp")
const MYSTERIOUS_QUERIES_N_O_H_AR_DS_YNTH = preload("uid://b7jje1ur12heo")
const BERGINNING_OF_THE_END = preload("uid://tvvb2ow17jyt")



var music_picker : int = 1

@onready var timer: Timer = $Timer




@export var timer_delay : int = 60
@export var starting_delay : int = 1




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_picker = randi_range(1,3)
	if music_picker == 1:
		stream = MYSTERIOUS_QUERIES_N_O_H_AR_DS_YNTH
	elif music_picker == 2:
		stream = FREQUENTLY_ETHEREAL
	elif music_picker == 3:
		stream = BERGINNING_OF_THE_END
	
	timer.start(1)



func _on_timer_timeout() -> void:
	play()
	timer_delay = randf_range(60,120)
	timer.start(timer_delay)
