extends Node

const save_location = "user://saves.json"

var content : Dictionary = {
	"advancements" = Var.advancements,
	"score" = Var.score,
	"pet" = Var.pet,
	"first" = Var.first
	}

func _ready() -> void:
	_load()

func _save():
	content = {
		"advancements": Var.advancements,
		"score": Var.score,
		"pet": Var.pet,
		"first": Var.first,
		"Music": Var.Music,
		"SFX": Var.SFX
	}
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	if file == null:
		print("Save failed: ", FileAccess.get_open_error())
		return
	file.store_string(JSON.stringify(content))
	file.close()

func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		file.close()
		if data == null:
			print("Failed to parse save file")
			return
		Var.advancements = data["advancements"]
		Var.score = data["score"]
		Var.pet = data["pet"]
		Var.first = data["first"]
		Var.Music = data["Music"]
		Var.SFX = data["SFX"]


func _delete_save():
	Var.advancements = [false,false,false,false,false,false]
	Var.score = [100000000,100000000,100000000]
	Var.pet = 0
	Var.first = true
	Var.gone = false
	Var.check = false
	_save()
	OS.set_restart_on_exit(true)
	get_tree().reload_current_scene()
