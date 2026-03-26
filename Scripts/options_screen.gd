extends Node2D


@onready var master: CheckButton = $Master



func _ready() -> void:
	master.grab_focus()
