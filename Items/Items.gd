extends Resource
class_name ItemDetails, "res://Custom Icons/Item.svg"

enum ItemType {weapon, skin}

export(int) var id = 0
export(String) var item_name = "Ned"
export(String) var item_description = "This is Ned."
export(ItemType) var item_type = ItemType.skin
export(String) var item_skin_name = "ned_normal"
export(String) var item_weapon_name = "woord_sword"
export(int) var lower_weapon_damage = 0
export(int) var upper_weapon_damage = 4
