extends Node2D


@onready var swing_timer: Timer = $SwingTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var slash_anim: AnimatedSprite2D = $SlashAnim
@onready var swing_is_charged_particles: CPUParticles2D = $"../ChargeUI/SwingIsChargedParticles"


@onready var swing_hit_box: Area2D = $SwingHitBox



func _ready() -> void:
	SignalBus.connect("player_died", on_player_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if slash_anim.is_playing():
		swing_hit_box.monitoring = true
	else:
		swing_hit_box.monitoring = false



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Swing") and not GameState.is_swinging:
		GameState.is_swinging = true
		swing_timer.start()
		animation_player.play("Swing")
		slash_anim.play("Swing")
		
		


func _on_swing_timer_timeout() -> void:
	swing_is_charged_particles.emitting = true
	GameState.is_swinging = false



func on_player_died():
	visible = false
