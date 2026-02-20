extends Control

@onready var dialogue_text: RichTextLabel = $DialogueText



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("show_dialogue", show_dialogue)
	SignalBus.connect("hide_dialogue", hide_dialogue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_dialogue():
	visible = true
	
	
	if GameState.current_dialogue == "Quork":
		dialogue_text.text = "Hmmm, You are a quork, you say ... Wait what is a Quork?"


func hide_dialogue():
	visible = false
	dialogue_text.text = ""
