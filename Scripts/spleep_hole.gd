extends Node2D





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("trapped_in_a_hole"):
		body.trapped_in_a_hole()
		body.global_position = global_position
