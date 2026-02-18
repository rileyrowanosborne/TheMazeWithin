extends Control


@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("spawn_level_boss", on_level_boss_spawned)
	SignalBus.connect("level_boss_died", on_level_boss_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	texture_progress_bar.max_value = GameState.current_floor_boss_max_health
	texture_progress_bar.value = GameState.current_boss_health


func on_level_boss_spawned():
	visible = true



func on_level_boss_died():
	visible = false
