extends Node
var data : Dictionary = {}
var SAVEFOLDER = "user://savedata"
var SAVE_NAME_TEMPLATE = "save_%03d.save"
var id: int = 1


func _ready():
	_loadData()
	print("Save Data Loaded")
	
func _loadData():
	var save_path = SAVEFOLDER.plus_file(SAVE_NAME_TEMPLATE % id)
	var file: File = File.new()
	if not file.file_exists(save_path):
		_init_save_file(save_path)
	
	file.open(save_path, File.READ)
	data = file.get_var()
	file.close()


func _init_save_file(savepath: String):
	var directory = Directory.new()
	directory.make_dir(SAVEFOLDER)
	var save_game = File.new()
	save_game.open(savepath, File.WRITE)
	save_game.store_var(data)
	save_game.close()
	
func _update_save_file():
	var save_path = SAVEFOLDER.plus_file(SAVE_NAME_TEMPLATE % id)
	var save_game = File.new()
	save_game.open(save_path, File.WRITE)
	save_game.store_var(data)
	save_game.close()

#Functions that will be called.
func StoreValue(key, value):
	data[key] = value
	_update_save_file()
	
func GetValue(key):
	if data.has(key):
		var val = data[key]
		if val == null:
			return 0
		return val
	else:
		return 0