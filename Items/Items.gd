extends Resource
class_name ItemDetails, "res://Custom Icons/Item.svg"
enum rare_levels {
	Worthless, #White
	Common, #Green
	Rare, #Blue
	Superb, #Purple
	Legendary #Orange
}

# ID CODES
# Skins/Armor: 1000-1999
# Weapons: 2000-2999
export(int) var id = 0
export(String) var item_name = "Ned"
export(String) var item_description = "This is Ned."
export(rare_levels) var rarity = rare_levels.Worthless

func GetRarityColor():
	match rarity:
		rare_levels.Worthless:
			return "white"
		rare_levels.Common:
			return "#37e02c"
		rare_levels.Rare:
			return "#2f64e0"
		rare_levels.Superb:
			return "#a513f7"
		rare_levels.Legendary:
			return "#f76221"
	return "white"

func GetRarityText():
	return rare_levels.keys()[rarity]
