extends TextureRect
const weaponClass = preload("res://Items/Weapon_Item.gd")
const skinClass = preload("res://Items/Skin_Item.gd")
var item
export var non_clickable = false
signal newSkinEquipted
signal newWeaponEquipted

func clear():
	item = null
	$Sprite.visible = false

func setItem(itm):
	item = itm
	if item is weaponClass:
		$Sprite.animation = item.item_weapon_name
		$Sprite.rotation_degrees = 45
	elif item is skinClass:
		$Sprite.animation = item.item_skin_name
		$Sprite.rotation_degrees = 0
	$Sprite.visible = true

func _on_Button_pressed():
	if non_clickable == false:
		if item is skinClass:
			SaveSystem.StoreValue("current_skin", item.id)
			emit_signal("newSkinEquipted", item.item_name)
		elif item is weaponClass:
			SaveSystem.StoreValue("current_weapon", item.id)
			emit_signal("newWeaponEquipted")

func PlayEquipAnimation():
	$AnimationPlayer.play("equip")
