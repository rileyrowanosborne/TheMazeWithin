extends Control


@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var boss_title_text: RichTextLabel = $BossTitleText


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("spawn_level_boss", on_level_boss_spawned)
	SignalBus.connect("level_boss_died", on_level_boss_died)
	SignalBus.connect("orm_phase_change", on_orm_phase_change)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	texture_progress_bar.max_value = GameState.current_floor_boss_max_health
	texture_progress_bar.value = GameState.current_boss_health


func on_level_boss_spawned():
	visible = true
	if GameState.current_chapter == 1:
		boss_title_text.text = "Oslo, the Under King"
	elif GameState.current_chapter == 2:
		boss_title_text.text = "Quork, the Unwell"
	elif GameState.current_chapter == 3:
		boss_title_text.text = "Aed, the Cruel"
	elif GameState.current_chapter == 4:
		if GameState.orm_current_phase == 1:
			boss_title_text.text = "Orm, the Great"


func on_level_boss_died():
	visible = false



func on_orm_phase_change():
	boss_title_text.text = "Orm, the Great Defiler"
