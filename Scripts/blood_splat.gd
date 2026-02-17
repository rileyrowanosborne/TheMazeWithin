extends Node2D


const BLOOD_SPLATTER_1 = preload("res://Assets/Sprites/BloodSplatter.png")
const BLOOD_SPLATTER_2 = preload("res://Assets/Sprites/BloodSplatter2.png")
const BLOOD_SPLATTER_3 = preload("res://Assets/Sprites/BloodSplatter3.png")
const BLOOD_SPLATTER_4 = preload("res://Assets/Sprites/BloodSplatter4.png")
const BLOOD_SPLATTER_5 = preload("res://Assets/Sprites/BloodSplatter5.png")


@onready var blood_splat_sprite: Sprite2D = $BloodSplatSprite

var random_blood_splat : int

func _ready() -> void:
	
	random_blood_splat = randi_range(1,5)
	
	if random_blood_splat == 1:
		blood_splat_sprite.texture = BLOOD_SPLATTER_1
	elif random_blood_splat == 2:
		blood_splat_sprite.texture = BLOOD_SPLATTER_2
	elif random_blood_splat == 3:
		blood_splat_sprite.texture = BLOOD_SPLATTER_3
	elif random_blood_splat == 4:
		blood_splat_sprite.texture = BLOOD_SPLATTER_4
	elif random_blood_splat == 5:
		blood_splat_sprite.texture = BLOOD_SPLATTER_5
