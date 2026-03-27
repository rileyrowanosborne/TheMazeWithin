extends Control


@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var player_shielded_icon: TextureRect = $PlayerShieldedIcon
@onready var hit_anim: AnimatedSprite2D = $HitAnim

@onready var low_hp: AnimatedSprite2D = $LowHP


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("player_hit", on_player_hit)
	SignalBus.connect("player_respawn", reset_health)
	SignalBus.connect("update_health", update_health)



func on_player_hit():
	
	if GameState.player_is_invul:
		print("Dodged")
	else:
		hit_anim.play("default") 
	health_check()


func update_health():
	health_check()

func health_check():
	texture_progress_bar.value = GameState.current_player_health


func reset_health():
	texture_progress_bar.value = 4


func _process(delta: float) -> void:
	if GameState.player_special_amount > 0:
		player_shielded_icon.visible = true
	else:
		player_shielded_icon.visible = false
		
