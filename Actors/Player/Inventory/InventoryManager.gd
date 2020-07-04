extends Node2D
export var max_inventory_size = 50
var myInventory: Array

func _ready():
	myInventory = SaveSystem.GetValue("inventory")

func RemoveItem(id: int):
	if myInventory.size() <= 0:
		return false
	myInventory.erase(id)
	_updateInventory()
	return true
	
func AddItem(id: int):
	if myInventory.size() >= max_inventory_size:
		return false
	myInventory.append(id)
	myInventory.sort()
	_updateInventory()
	return true
	
func _updateInventory():
	SaveSystem.StoreValue("inventory", myInventory)
