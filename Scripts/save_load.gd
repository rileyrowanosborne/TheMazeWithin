extends Node

const save_location = "user://SaveFile.json"


var contents_to_save : Dictionary = {
	"current_chapter" : 1,
	"chapter_one_completed" : false,
	"chapter_two_completed" : false,
	"chapter_three_completed" : false,
	"chapter_four_completed" : false,
	"master" : true,
	"sfx" : true,
	"music" : true
}


func _ready() -> void:
	_load()

func _save():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contents_to_save.duplicate())
	file.close()


func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		contents_to_save.current_chapter = save_data.current_chapter
