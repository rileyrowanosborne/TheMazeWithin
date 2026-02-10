extends Node2D


@onready var swing_timer: Timer = $SwingTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var slash_anim: AnimatedSprite2D = $SlashAnim

@onready var swing_hit_box: Area2D = $SwingHitBox


var is_swinging : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	look_at(get_global_mouse_position())
	
	
	
	
	if is_swinging:
		swing_hit_box.monitoring = true
	
	else:
		swing_hit_box.monitoring = false



func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Swing") and not is_swinging:
		is_swinging = true
		swing_timer.start()
		animation_player.play("Swing")
		slash_anim.play("Swing")
		
		


func _on_swing_timer_timeout() -> void:
	is_swinging = false
