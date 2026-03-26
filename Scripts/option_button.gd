extends OptionButton


@onready var texture_rect: TextureRect = $TextureRect


const ITEM_DASH = preload("uid://bjtf2yeggi6tp")
const ITEM_MINI_ME = preload("uid://dq7sdgsfhb2l3")
const ITEM_SHIELD = preload("uid://dlhfl6emf0ylm")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass






func _on_item_selected(index: int) -> void:
	if index == 0:
		texture_rect.texture = ITEM_MINI_ME
	elif index == 1:
		texture_rect.texture = ITEM_DASH
	elif index == 2:
		texture_rect.texture = ITEM_SHIELD
