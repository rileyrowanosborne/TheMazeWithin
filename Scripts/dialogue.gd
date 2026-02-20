extends Control

@onready var dialogue_text: RichTextLabel = $DialogueText
@onready var mushroom_timer: Timer = $MushroomTimer



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
	elif GameState.current_dialogue == "Mushroom":
		dialogue_text.text = "Hmmmm... I prolly shouldn't have eaten that... Was that an old man?"
		mushroom_timer.start()
	


func hide_dialogue():
	visible = false
	dialogue_text.text = ""


func _on_mushroom_timer_timeout() -> void:
	hide_dialogue()
