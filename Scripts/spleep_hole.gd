extends Node2D


var can_absorb : bool = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("trapped_in_a_hole") and can_absorb:
		can_absorb = false
		body.trapped_in_a_hole()
		body.global_position = global_position
		
		get_parent().total_spleeps_collected += 1
		get_parent().check_total_spleeps()
		print(get_parent().total_spleeps_collected)
