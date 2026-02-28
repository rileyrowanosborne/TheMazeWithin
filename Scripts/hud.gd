extends CanvasLayer


@onready var boss_entered_text: RichTextLabel = $IngameHud/BossScreenText/BossEnteredText
@onready var boss_text_timer: Timer = $IngameHud/BossScreenText/BossTextTimer
@onready var level_change_timer: Timer = $IngameHud/BossScreenText/LevelChangeTimer
@onready var door_text: RichTextLabel = $IngameHud/BossScreenText/DoorText


@onready var player_died_text: Control = $IngameHud/PlayerDiedText
@onready var death_text_timer: Timer = $IngameHud/PlayerDiedText/DeathTextTimer





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("begin_boss_spawning", begin_boss_spawning)
	SignalBus.connect("level_boss_died", on_level_boss_died)
	SignalBus.connect("player_died", on_player_died)
	SignalBus.connect("pause_game", on_pause_signal_received)
	SignalBus.connect("unpause_game", on_unpause_signal_received)
	
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
	
	

func on_pause_signal_received():
	pass



func on_unpause_signal_received():
	pass
