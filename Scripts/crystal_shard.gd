extends RigidBody2D




@export var health : int


@onready var shard_anims: AnimatedSprite2D = $ShardAnims
@onready var spark: AnimatedSprite2D = $Spark
@onready var spark_2: AnimatedSprite2D = $Spark2
@onready var spark_3: AnimatedSprite2D = $Spark3



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Crystal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func health_check():
	if health > 0:
		set_anim("Hit")
		hit_sparks()
	else:
		set_anim("Break")
		

func hit_sparks():
	spark.play("default")
	spark_2.play("default")
	spark_3.play("default")


func take_damage():
	health -= 1
	health_check()


func set_anim(anim : String):
	if shard_anims.animation != anim:
		shard_anims.play(anim)


func _on_shard_anims_animation_finished() -> void:
	if shard_anims.animation == "Break":
		SignalBus.emit_signal("crystal_break")
		queue_free()
	else:
		set_anim("Idle")
