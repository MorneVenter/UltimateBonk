extends TextureRect
const weaponClass = preload("res://Items/Weapon_Item.gd")
const skinClass = preload("res://Items/Skin_Item.gd")
var item
export var non_clickable = false
signal newSkinEquipted
signal newWeaponEquipted

func _ready():
	$PopupLayer/Popup.visible = false

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
	_setTooltip()

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
	
func _setTooltip():
	$PopupLayer/Popup/TextureRect/NameText.bbcode_text = '[center]' + String(item.item_name) + '[/center]'
	$PopupLayer/Popup/TextureRect/DescriptionText.bbcode_text = item.item_description
	if item is weaponClass:
		$PopupLayer/Popup/TextureRect/StatText.bbcode_text = '[center]' + String(item.lower_weapon_damage) + \
		'-' + String(item.upper_weapon_damage) + '[/center]'
		$PopupLayer/Popup/TextureRect/DmgText.bbcode_text = 'Damage Per Swing'
	else:
		$PopupLayer/Popup/TextureRect/DmgText.bbcode_text = ''
		$PopupLayer/Popup/TextureRect/StatText.bbcode_text = ''


func showPopup():
	$PopupLayer/Popup.visible = true
	$PopupLayer/Popup.rect_position = rect_global_position
	
func hidePopup():
	$PopupLayer/Popup.visible = false


func _on_Button_mouse_entered():
	if not item == null:
		showPopup()


func _on_Button_mouse_exited():
	if not item == null:
		hidePopup()
