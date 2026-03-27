extends Node2D




@onready var rich_text_label: RichTextLabel = $RichTextLabel

@onready var timer: Timer = $Timer


var text_progress : int = 1



func _ready() -> void:
	update_text()
	timer.start()


func update_text():
	if text_progress == 1:
		rich_text_label.text = "IT WOULD SEEM YOU HAVE WON..."
		timer.start()
	elif text_progress == 2:
		rich_text_label.text = "NO, THAT CAN'T BE RIGHT..."
		timer.start()
	elif  text_progress == 3:
		rich_text_label.text = "AHH, I SEE, YOU HAVE BEAT THE DEMO."
		timer.start()
	elif text_progress == 4:
		rich_text_label.text = "STILL, VERY NICE INDEED."
		timer.start()
	elif  text_progress == 5:
		rich_text_label.text = "THAT IS NO SMALL FEAT."
		timer.start()
	elif text_progress == 6:
		get_tree().change_scene_to_file("res://Scenes/Chapters/Chapter Cutsenes/end_screen.tscn")




func _on_timer_timeout() -> void:
	text_progress += 1
	update_text()
