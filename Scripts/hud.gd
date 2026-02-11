extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("begin_boss_spawning", begin_boss_spawning)
	SignalBus.connect("level_boss_died", on_level_boss_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func begin_boss_spawning():
	$BossScreenText/BossTextTimer.start()
	$BossScreenText/BossEnteredText.visible = true
	$BossScreenText/BossEnteredText.text = "A STRONG ENEMY IS APPROACHING"


func _on_boss_text_timer_timeout() -> void:
	$BossScreenText/BossEnteredText.visible = false
	SignalBus.emit_signal("spawn_level_boss")


func on_level_boss_died():
	$BossScreenText/LevelChangeTimer.start()
	$BossScreenText/BossEnteredText.visible = true
	$BossScreenText/BossEnteredText.text = "A STRONG ENEMY HAS FALLEN"


func _on_level_change_timer_timeout() -> void:
	SignalBus.emit_signal("change_level")
