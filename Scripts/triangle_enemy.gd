extends CharacterBody2D

#misc odes
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_particles: CPUParticles2D = $DeathParticles


#raycast nodes
@onready var ray_cast_left: RayCast2D = $RayCasts/RayCastLeft
@onready var ray_cast_left_2: RayCast2D = $RayCasts/RayCastLeft2
@onready var ray_cast_down: RayCast2D = $RayCasts/RayCastDown
@onready var ray_cast_down_2: RayCast2D = $RayCasts/RayCastDown2
@onready var ray_cast_right: RayCast2D = $RayCasts/RayCastRight
@onready var ray_cast_right_2: RayCast2D = $RayCasts/RayCastRight2
@onready var ray_cast_up: RayCast2D = $RayCasts/RayCastUp
@onready var ray_cast_up_2: RayCast2D = $RayCasts/RayCastUp2


#timer nodes
@onready var damage_timer: Timer = $Timers/DamageTimer
@onready var death_timer: Timer = $Timers/DeathTimer





#general variables
@export var is_shooting : bool
const SPEED = 20
var current_direction : Vector2

#health variables
const MIN_HEALTH = 0
var max_health : int = 3
var current_health : int
var boss_mode_active : bool = false
var is_dying : bool = false


var is_hittable : bool = false
const MAX_SHIELDS : int = 4
var current_shields : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Enemy")
	add_to_group("Triangle")
	current_health = max_health
	current_direction = Vector2(1,0)
	current_shields = MAX_SHIELDS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(current_health)
	
	if ray_cast_right.is_colliding() or ray_cast_right_2.is_colliding():
		current_direction.x = -1
	
	if ray_cast_down.is_colliding() or ray_cast_down_2.is_colliding():
		current_direction.y = -1
	
	if ray_cast_up.is_colliding() or ray_cast_up_2.is_colliding():
		current_direction.y = 1
	
	if ray_cast_left.is_colliding() or ray_cast_left_2.is_colliding():
		current_direction.x = 1
	
	if is_dying:
		scale -= Vector2(.5,.5) * delta


func _physics_process(delta: float) -> void:
	
	velocity = current_direction * SPEED
	
	move_and_slide()


func take_damage():
	if is_hittable:
		current_health -= 1
		SignalBus.emit_signal("enemy_hit")
		animated_sprite_2d.play("Hit")
		damage_timer.start()
		life_check()



func life_check():
	if current_health <= MIN_HEALTH:
		die()


func die():
	is_shooting = false
	is_dying = true
	animated_sprite_2d.play("Hit")
	death_particles.emitting = true
	death_timer.start()
	
	if boss_mode_active:
		SignalBus.emit_signal("level_boss_died")
		boss_mode_active = false
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Testing"):
		if is_shooting:
			is_shooting = false
			print("Testing Mode: ON")
		elif not is_shooting:
			is_shooting = true
			print("Testing Mode: OFF")


func _on_death_timer_timeout() -> void:
	queue_free()


func _on_damage_timer_timeout() -> void:
	animated_sprite_2d.play("Idle")
