extends Node2D



@export var test_room_seed : int



func _ready() -> void:
	$TilemapGaeaRenderer/WalkerGenerator.seed = test_room_seed
