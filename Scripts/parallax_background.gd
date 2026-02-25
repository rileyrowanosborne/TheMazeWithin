extends ParallaxBackground




@onready var faces: Parallax2D = $Faces
@onready var faces_2: Parallax2D = $Faces2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	faces.autoscroll = Vector2(100,0)
	faces_2.autoscroll = Vector2(200,0)
