extends CanvasLayer



@onready var current_weapon_text: RichTextLabel = $CurrentWeaponText
@onready var weapon_texture: Sprite2D = $PictureFrame9/WeaponTexture
@onready var picture_frame_9: Sprite2D = $PictureFrame9


const BASE_BALL_BAT_SOLO = preload("uid://bc6150todq4nx")
const GOLF_CLUB_SOLO = preload("uid://x4yhyumvh2w6")
const PENCIL_SOLO = preload("uid://dfonrvyhxgkt4")
const SWORD_SOLO = preload("uid://b2sakjfjyrc2g")
const SPOON_SOLO = preload("uid://bugkutibvlu1r")



var in_range_ : String





func _ready() -> void:
	current_weapon_text.text = ""
	
	
	
	


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Interact"):
		if in_range_ == "Bat":
			GameState.current_weapon = GameState.weapon_types.baseball_bat
		elif in_range_ == "Club":
			GameState.current_weapon = GameState.weapon_types.golf_club
		elif in_range_ == "Spoon":
			GameState.current_weapon = GameState.weapon_types.spoon
		elif in_range_ == "Pencil":
			GameState.current_weapon = GameState.weapon_types.pencil
		elif in_range_ == "Sword":
			GameState.current_weapon = GameState.weapon_types.sword
		SignalBus.emit_signal("unpause_game") 
		
	
		if GameState.current_chapter == 0:
			get_tree().change_scene_to_file("res://Scenes/test_room.tscn")
	
		elif GameState.current_chapter == 1:
			get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_one.tscn")
		elif GameState.current_chapter == 1.5:
			get_tree().change_scene_to_file('res://Scenes/Chapters/Completed Chapters/completed_chapter_one.tscn')
		elif GameState.current_chapter == 2:
			get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_two.tscn")
		elif GameState.current_chapter == 2.5:
			get_tree().change_scene_to_file("res://Scenes/Chapters/Completed Chapters/completed_chapter_two.tscn")
		elif GameState.current_chapter == 3:
			get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_three.tscn")
		elif GameState.current_chapter == 3.5:
			get_tree().change_scene_to_file("res://Scenes/Chapters/Completed Chapters/completed_chapter_three.tscn")
		elif GameState.current_chapter == 4:
			get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/chapter_four.tscn")
		elif GameState.current_chapter == 4.5:
			get_tree().change_scene_to_file("res://Scenes/Chapters/Game Chapters/museum_of_doubts.tscn")
	




func _on_club_range_body_entered(body: Node2D) -> void:
	current_weapon_text.text = "'Lil' Putter'"
	in_range_ = "Club"
	weapon_texture.texture = GOLF_CLUB_SOLO
	picture_frame_9.visible = true
	



func _on_club_range_body_exited(body: Node2D) -> void:
	current_weapon_text.text = ""
	in_range_ = ""
	picture_frame_9.visible = false



func _on_bat_range_body_entered(body: Node2D) -> void:
	current_weapon_text.text = "'Big Dawg'"
	in_range_ = "Bat"
	weapon_texture.texture = BASE_BALL_BAT_SOLO 
	picture_frame_9.visible = true 



func _on_bat_range_body_exited(body: Node2D) -> void:
	current_weapon_text.text = ""
	in_range_ = ""
	picture_frame_9.visible = false


func _on_pencil_range_body_entered(body: Node2D) -> void:
	current_weapon_text.text = "'Pain Distributor'"
	weapon_texture.texture = PENCIL_SOLO
	in_range_ = "Pencil" 
	picture_frame_9.visible = true

func _on_pencil_range_body_exited(body: Node2D) -> void:
	current_weapon_text.text = ""
	in_range_ = ""
	picture_frame_9.visible = false


func _on_spoon_range_body_entered(body: Node2D) -> void:
	current_weapon_text.text = "'The Soft Boiler'"
	weapon_texture.texture = SPOON_SOLO
	in_range_ = "Spoon"
	picture_frame_9.visible = true


func _on_spoon_range_body_exited(body: Node2D) -> void:
	current_weapon_text.text = ""
	in_range_ = ""
	picture_frame_9.visible = false


func _on_sword_range_body_entered(body: Node2D) -> void:
	current_weapon_text.text = "'Szeth-Son-Son-Vallano'"
	weapon_texture.texture = SWORD_SOLO
	in_range_ = "Sword"
	picture_frame_9.visible = true
	
	
func _on_sword_range_body_exited(body: Node2D) -> void:
	current_weapon_text.text = ""
	in_range_ = ""
	picture_frame_9.visible = false
	
