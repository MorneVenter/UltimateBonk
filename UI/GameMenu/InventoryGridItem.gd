extends TextureRect
const weaponClass = preload("res://Items/Weapon_Item.gd")
const skinClass = preload("res://Items/Skin_Item.gd")
var item
export var non_clickable = false

func clear():
	item = null
	$Sprite.visible = false

func setItem(itm):
	item = itm
	if item is weaponClass:
		$Sprite.animation = item.item_weapon_name
	elif item is skinClass:
		$Sprite.animation = item.item_skin_name
	$Sprite.visible = true

func _on_Button_pressed():
	if non_clickable == false:
		print(item)
