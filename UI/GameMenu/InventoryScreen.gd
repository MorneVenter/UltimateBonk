extends Control

var myInventory


func setInventory(inv):
	myInventory = inv
	refreshInventory()
	
func refreshInventory():
	setAvatarSkin()
	setEquipSkin()
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
