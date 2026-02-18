extends CharacterBody2D

@export var circle_scene : PackedScene
@export var square_scene : PackedScene
@export var triangle_scene : PackedScene
@export var blood_splat_scene : PackedScene

var circle_instance
var square_instance
var triangle_instance



@onready var orm_head: CharacterBody2D = $Heads/OrmHead
@onready var orm_head_2: CharacterBody2D = $Heads/OrmHead2
@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer
@onready var damage_timer: Timer = $DamageTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_particles: CPUParticles2D = $DeathParticles
@onready var death_timer: Timer = $DeathTimer



var attack_cooldown_lenth : float = 3.0

var random_attack : int

const MIN_HEALTH = 0
var max_health : int = 10
var current_health : int
var boss_mode_active : bool = false
var is_dying : bool = false

var total_boss_enemies : int
var max_boss_enemies : int = 2

@export var is_shooting : bool 
var is_hittable : bool = true


func _ready() -> void:
	add_to_group("Enemy")
	current_health = max_health
	attack_cooldown_timer.start(attack_cooldown_lenth)



func _process(delta: float) -> void:
	if boss_mode_active:
		GameState.current_boss_health = current_health




func spawn_circle(world_location : Vector2):
	if circle_scene:
		circle_instance = circle_scene.instantiate()
		get_parent().add_child(circle_instance)
		circle_instance.global_position = world_location

func spawn_square(world_location : Vector2):
	if square_scene:
		square_instance = square_scene.instantiate()
		get_parent().add_child(square_instance)
		square_instance.global_position = world_location

func spawn_triangle(world_location : Vector2):
	if triangle_scene:
		triangle_instance = circle_scene.instantiate()
		get_parent().add_child(triangle_instance)
		triangle_instance.global_position = world_location


func _on_attack_cooldown_timer_timeout() -> void:
	if GameState.orm_current_phase == 1:
		random_attack = randi_range(1,2)
		attack(random_attack)
	elif GameState.orm_current_phase == 2:
		if GameState.total_boss_enemies < 2:
			random_attack = randi_range(1,5)
		else:
			random_attack = randi_range(1,2)
		attack(random_attack)



func attack(attack_type : int):
	attack_cooldown_timer.start(attack_cooldown_lenth)
	print(attack_type)
	
	if attack_type == 1:
		orm_head.begin_attack()
	elif attack_type == 2:
		orm_head_2.begin_attack()
	elif attack_type == 3:
		if GameState.total_boss_enemies < max_boss_enemies:
			spawn_circle(global_position)
			GameState.total_boss_enemies += 1
	elif attack_type == 4:
		if GameState.total_boss_enemies < max_boss_enemies:
			spawn_square(global_position)
			GameState.total_boss_enemies += 1
	elif attack_type == 5:
		if GameState.total_boss_enemies < max_boss_enemies:
			spawn_triangle(global_position)
			GameState.total_boss_enemies += 1
	

func take_damage():
	if is_hittable:
		current_health -= 1
		SignalBus.emit_signal("enemy_hit")
		animated_sprite_2d.play("Hit")
		damage_timer.start()
		life_check()
		if current_health <= 15:
			GameState.orm_current_phase = 2
			attack_cooldown_lenth = 1.5
			SignalBus.emit_signal("orm_phase_change")
			attack_cooldown_timer.start(attack_cooldown_lenth)



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


func spawn_blood_splat(world_location : Vector2):
	if blood_splat_scene:
		var blood_splat_instance = blood_splat_scene.instantiate()
		get_tree().current_scene.call_deferred("add_child", blood_splat_instance)
		blood_splat_instance.global_position = world_location




func _on_damage_timer_timeout() -> void:
	animated_sprite_2d.play("Idle")


func _on_death_timer_timeout() -> void:
	queue_free()
