extends CharacterBody2D

#misc nodes
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

#launcher nodes
@onready var projectile_launcher: Node2D = $ProjectileLaunchers/ProjectileLauncher
@onready var projectile_launcher_2: Node2D = $ProjectileLaunchers/ProjectileLauncher2
@onready var projectile_launcher_3: Node2D = $ProjectileLaunchers/ProjectileLauncher3
@onready var projectile_launcher_4: Node2D = $ProjectileLaunchers/ProjectileLauncher4

#timer nodes
@onready var damage_timer: Timer = $Timers/DamageTimer
@onready var direction_timer: Timer = $Timers/DirectionTimer
@onready var death_timer: Timer = $Timers/DeathTimer

#general variables
@export var is_shooting : bool = true
const SPEED = 20
var current_direction : Vector2

#health variables
const MIN_HEALTH = 0
const MAX_HEALTH = 3
var current_health : int
var is_dying : bool = false
var boss_mode_active : bool = false

var is_enemy_hittable : bool


func _ready() -> void:
	add_to_group("Enemy")
	add_to_group("Square")
	current_health = MAX_HEALTH
	current_direction = Vector2(1,0)



func _process(delta: float) -> void:
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
	current_health -= 1
	SignalBus.emit_signal("enemy_hit")
	animated_sprite_2d.play("Hit")
	damage_timer.start()
	life_check()


func _on_damage_timer_timeout() -> void:
	animated_sprite_2d.play("Idle")



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
	


func _on_death_timer_timeout() -> void:
	queue_free()



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Testing"):
		if is_shooting:
			is_shooting = false
			print("Testing Mode: ON")
		elif not is_shooting:
			is_shooting = true
			print("Testing Mode: OFF")
