extends Area2D




var in_range : bool


func _ready() -> void:
	in_range = false



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range = false
