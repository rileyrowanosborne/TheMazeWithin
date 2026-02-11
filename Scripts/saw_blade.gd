extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	sprite_2d.rotation_degrees += 560 * delta
	
	#if GameState.player_is_invul:
		#$HitBox.set_collision_mask_value(1,false)
	#else:
		#$HitBox.set_collision_mask_value(1,true)



func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if not GameState.player_is_invul:
			SignalBus.emit_signal("player_hit")
		else:
			print("Dodged!")
		
