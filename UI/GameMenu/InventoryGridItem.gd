extends TextureRect
const weaponClass = preload("res://Items/Weapon_Item.gd")
const skinClass = preload("res://Items/Skin_Item.gd")
var item
var has_focus: bool = false
export var non_clickable = false
signal newSkinEquipted
signal newWeaponEquipted
signal deleteItem

func _ready():
	$PopupLayer/Popup.visible = false

func _process(delta):
	if has_focus and not non_clickable:
		deleteItemCheck()

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
			emit_signal("newSkinEquipted", item.id)
		elif item is weaponClass:
			emit_signal("newWeaponEquipted", item.id)

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
	has_focus = true
	
func hidePopup():
	$PopupLayer/Popup.visible = false
	has_focus = false
	
func _on_Button_mouse_entered():
	if not item == null:
		showPopup()


func _on_Button_mouse_exited():
	if not item == null:
		hidePopup()
		
func deleteItemCheck():
	if Input.is_action_just_pressed("ui_secondary_action"):
		hidePopup()
		emit_signal("deleteItem", item.id)
