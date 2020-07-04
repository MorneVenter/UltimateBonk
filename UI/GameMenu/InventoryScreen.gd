extends Control

var myInventory

func _ready():
	connectSignals()

func connectSignals():
	var slots = get_tree().get_nodes_in_group("InventoryGridItem")
	for slt in slots:
		slt.connect("newSkinEquipted", self, "updateSkin")
		slt.connect("newWeaponEquipted", self, "updateWeapon")
		slt.connect("deleteItem", self, "deleteItemFromInv")

func setInventory(inv):
	myInventory = inv
	refreshInventory()
	
func refreshInventory():
	setAvatarSkin()
	setEquipSkin()
	setEquipWeapon()
	fillInventory()
	
func setAvatarSkin():
	var skin = SaveSystem.GetValue("current_skin")
	if skin == 0:
		$MenuBackground/TabContainer/Character/PlayerView/Container/PlayerAvatar.animation = "ned_normal"
	else:
		$MenuBackground/TabContainer/Character/PlayerView/Container/PlayerAvatar.animation = ItemLoader.GetItem(skin).item_skin_name

func setEquipSkin():
	var skin = SaveSystem.GetValue("current_skin")
	var itm = ItemLoader.GetItem(skin)
	if itm == null:
		$MenuBackground/TabContainer/Character/PlayerView/Container/GearArea/Skin.setItem(ItemLoader.GetItem(1001))
	else:
		$MenuBackground/TabContainer/Character/PlayerView/Container/GearArea/Skin.setItem(itm)
		$MenuBackground/TabContainer/Character/PlayerView/Container/nameText.text = itm.item_name
		$MenuBackground/TabContainer/Character/PlayerView/Container/GearArea/Skin.PlayEquipAnimation()

func setEquipWeapon():
	var wep = SaveSystem.GetValue("current_weapon")
	var itm = ItemLoader.GetItem(wep)
	if itm == null:
		$MenuBackground/TabContainer/Character/PlayerView/Container/GearArea/Weapon.setItem(ItemLoader.GetItem(2001))
	else:
		$MenuBackground/TabContainer/Character/PlayerView/Container/GearArea/Weapon.setItem(itm)
		$MenuBackground/TabContainer/Character/PlayerView/Container/GearArea/Weapon.PlayEquipAnimation()

func fillInventory():
	var slots = get_tree().get_nodes_in_group("InventoryGridItem")
	for slt in slots:
		if not slt.non_clickable:
			slt.clear()
	var x = 0
	for itm in myInventory.myInventory:
		while slots[x].non_clickable:
			x+=1
		slots[x].setItem(ItemLoader.GetItem(itm))
		x += 1
		
func updateSkin(id: int):
	myInventory.RemoveItem(id)
	myInventory.AddItem(SaveSystem.GetValue("current_skin"))
	SaveSystem.StoreValue("current_skin", id)
	$MenuBackground/TabContainer/Character/PlayerView/Container/nameText.text = ItemLoader.GetItem(id).item_name
	setAvatarSkin()
	setEquipSkin()
	fillInventory()

func updateWeapon(id: int):
	myInventory.RemoveItem(id)
	myInventory.AddItem(SaveSystem.GetValue("current_weapon"))
	SaveSystem.StoreValue("current_weapon", id)
	setEquipWeapon()
	fillInventory()

func deleteItemFromInv(id: int):
	myInventory.RemoveItem(id)
	fillInventory()


func _on_QuitButton_pressed():
	get_tree().change_scene("res://UI/Menu/TitleScreen.tscn")
