extends Node

var AllItems = []

func _ready():
	loadAllItems()

func loadAllItems():
	var item_directory = Directory.new()
	item_directory .open("res://Items/AllItems")
	item_directory.list_dir_begin(true)
	
	var item = item_directory.get_next()
	while item != "":
		AllItems.append(load("res://Items/AllItems/" + item))
		item = item_directory.get_next()

func GetItem(id: int):
	for itm in AllItems:
		if itm.id == id:
			return itm
	return null
