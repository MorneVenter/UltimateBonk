extends "res://Items/Items.gd"
class_name Item_Weapon, "res://Custom Icons/Item.svg"

export(String) var item_weapon_name = "wood_sword"
export(int) var lower_weapon_damage = 0
export(int) var upper_weapon_damage = 4
export(float) var weapon_crit = 0.1

func GetCritDisplayNumber():
	var x = int(round(weapon_crit*100))
	return str(x)
