extends "res://Items/Items.gd"
class_name Item_Skin, "res://Custom Icons/Item.svg"

export(String) var item_skin_name = "ned_normal"
export(int) var lower_passive_doots = 1
export(int) var upper_passive_doots = 2
export(float) var speed_bonus = 0.1

func GetSpeedDisplayNumber():
	var x = int(round(speed_bonus*100))
	return str(x)
