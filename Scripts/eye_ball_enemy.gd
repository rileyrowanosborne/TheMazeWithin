extends CharacterBody2D




var player_in_range : bool = false
@export var interactable_type : String


@onready var eyes: AnimatedSprite2D = $Eyes
@onready var mouth: AnimatedSprite2D = $Mouth




func _ready() -> void:
	add_to_group("Interactable")
	add_to_group(interactable_type)
	





func _input(event: InputEvent) -> void:
	if player_in_range:
		if event.is_action_pressed("Interact"):
			SignalBus.emit_signal("show_dialogue")
			set_mouth_anim("Talking")



func set_eyes_anim(anim : String):
	if eyes.animation != anim:
		eyes.play(anim)


func set_mouth_anim(anim : String):
	if mouth.animation != anim:
		mouth.play(anim)
