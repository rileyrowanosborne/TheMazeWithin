extends CanvasLayer


@onready var boss_entered_text: RichTextLabel = $IngameHud/BossScreenText/BossEnteredText
@onready var boss_text_timer: Timer = $IngameHud/BossScreenText/BossTextTimer
@onready var level_change_timer: Timer = $IngameHud/BossScreenText/LevelChangeTimer
@onready var door_text: RichTextLabel = $IngameHud/BossScreenText/DoorText


@onready var player_died_text: Control = $IngameHud/PlayerDiedText
@onready var death_text_timer: Timer = $IngameHud/PlayerDiedText/DeathTextTimer

@onready var pause_menu: Control = $PauseMenu
@onready var ingame_hud: Control = $IngameHud

@onready var crystal_timer: Timer = $IngameHud/BossScreenText/CrystalTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("begin_boss_spawning", begin_boss_spawning)
	SignalBus.connect("level_boss_died", on_level_boss_died)
	SignalBus.connect("player_died", on_player_died)
	SignalBus.connect("pause_game", on_pause_signal_received)
	SignalBus.connect("unpause_game", on_unpause_signal_received)
	SignalBus.connect("crystal_break", on_crystal_break)
	
	
	SignalBus.emit_signal("unpause_game")
	visible = true


func begin_boss_spawning():
	boss_text_timer.start()
	boss_entered_text.visible = true
	boss_entered_text.text = "A STRONG ENEMY IS APPROACHING"


func _on_boss_text_timer_timeout() -> void:
	boss_entered_text.visible = false
	SignalBus.emit_signal("spawn_level_boss")


func on_level_boss_died():
	level_change_timer.start()
	boss_entered_text.visible = true
	boss_entered_text.text = "A STRONG ENEMY HAS FALLEN"


func _on_level_change_timer_timeout() -> void:
	boss_entered_text.visible = false
	door_text.visible = true
	SignalBus.emit_signal("open_door")



func on_player_died():
	player_died_text.visible = true
	death_text_timer.start()


func _on_death_text_timer_timeout() -> void:
	player_died_text.visible = false
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and GameState.player_playing:
		if GameState.is_paused:
			SignalBus.emit_signal("unpause_game")
		else:
			SignalBus.emit_signal("pause_game")



func on_pause_signal_received():
	pause_menu.visible = true
	ingame_hud.visible = false



func on_unpause_signal_received():
	pause_menu.visible = false
	ingame_hud.visible = true


func _on_resume_button_pressed() -> void:
	SignalBus.emit_signal("unpause_game")



func _on_quit_button_pressed() -> void:
	SignalBus.emit_signal("unpause_game") 
	SaveLoad._save()
	get_tree().change_scene_to_file("res://Scenes/Chapters/Title Screen/title_screen.tscn")
	

func on_crystal_break():
	crystal_timer.start()
	boss_entered_text.visible = true
	boss_entered_text.text = "A STRANGE CRYSTAL HAS BEEN SHATTERED"


func _on_crystal_timer_timeout() -> void:
	boss_entered_text.visible = false


func _on_wepon_select_pressed() -> void:
	SignalBus.emit_signal("unpause_game")
