extends Node2D

var myWeaponItem

func _ready():
	pass # Replace with function body.


func setWeapon(wep_item):
	myWeaponItem = wep_item
	$AnimatedSprite.animation = myWeaponItem.item_weapon_name
