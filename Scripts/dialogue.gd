extends Control

@onready var dialogue_text: RichTextLabel = $DialogueText



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("begin_quork_dialogue", begin_quork_dialogue)
	SignalBus.connect("end_quork_dialogue", end_quork_dialogue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func begin_quork_dialogue():
	var quork_dialogue_progress : int = 1
	dialogue_text.text = "... What ... the hell is that."
	visible = true

func end_quork_dialogue():
	dialogue_text.text = ""
	visible = false
