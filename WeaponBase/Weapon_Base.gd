extends Node2D

var myWeaponItem

func setWeapon(wep_item):
	myWeaponItem = wep_item
	$AnimatedSprite.animation = myWeaponItem.item_weapon_name
