extends Control



@onready var mushoom_eating_cutscene: Node2D = $MushoomEatingCutscene



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("start_mushroom_cutscene", start_mushroom_cutscene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func start_mushroom_cutscene():
	
	mushoom_eating_cutscene.start_cutscene()
