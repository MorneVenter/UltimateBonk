extends Node2D
export var speed = 120
var speed_bonus = 0

var weaponDamage = [1,1]
var weaponCrit = 0

var passive_doots = [1,1]

var lerpStart = 0.2
var lerpCoficient = lerpStart
var facing_direction= 1
var isAttacking = false
var isInInventoryScreen = false
var mySkinItem
var canToggleInventory = true;
var rng = RandomNumberGenerator.new()

onready var InventoryScreen  = preload("res://UI/GameMenu/InventoryScreen.tscn")

func _ready():
	changeSkin()
	changeWeapon()

func _process(delta):
	pass
	
func _physics_process(delta):
	if not isAttacking and not isInInventoryScreen:
		movePlayer()

func _input(event):
	if not isInInventoryScreen:
		if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
			if event.position.x >= $Body.global_position.x:
				$Body/AnimatedSprite.flip_h = false
				facing_direction = 1
			else:
				$Body/AnimatedSprite.flip_h = true
				facing_direction = -1
			hit()
		if Input.is_action_just_pressed("hit_controller") and not isAttacking:
			hit()

	if Input.is_action_just_pressed("ui_inventory_menu"):
		toggleInventoryScreen()

func movePlayer():
	var dir = get_direction()*lerpCoficient
	$Body.move_and_slide(dir*(speed+speed_bonus))
	if dir == Vector2.ZERO:
		lerpCoficient = lerpStart
		$AnimationPlayer.current_animation = "idle"
	else:
		lerpCoficient = lerpCoficient+0.04 if lerpCoficient <= 1 else 1
		$AnimationPlayer.current_animation = "run"

func get_direction():
	var up = -1 if Input.is_action_pressed("ui_up") else 0
	var down = 1 if Input.is_action_pressed("ui_down") else 0
	var left =-1 if Input.is_action_pressed("ui_left") else 0
	var right = 1 if Input.is_action_pressed("ui_right") else 0
	var x = left+right
	var y = up+down
	
	if left == -1:
		$Body/AnimatedSprite.flip_h = true
		$Body/Weapon_Holder.rotation_degrees = 300
		facing_direction = -1
	elif right == 1:
		$Body/AnimatedSprite.flip_h = false
		$Body/Weapon_Holder.rotation_degrees = 60
		facing_direction = 1
	return Vector2(x,y).normalized()
	
func hit():
	isAttacking = true
	if facing_direction == 1:
		$AnimationPlayer.current_animation = "hit_right"
		$Body/PlayerHitRight/Right.disabled = false
	elif facing_direction == -1:
		$AnimationPlayer.current_animation = "hit_left"
		$Body/PlayerHitLeft/Left.disabled = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit_left" or anim_name == "hit_right":
		isAttacking = false
		$Body/PlayerHitRight/Right.disabled = true
		$Body/PlayerHitLeft/Left.disabled = true
		
func toggleInventoryScreen():
	if canToggleInventory:
		canToggleInventory = false
		if isInInventoryScreen: #hide inventory
			var child = $InventoryMenuHolder/Canvas.get_children()
			for n in child:
				n.queue_free()
			changeSkin()
			changeWeapon()
			isInInventoryScreen = false
		else: #show inventory
			isInInventoryScreen = true
			var inv = InventoryScreen.instance()
			inv.set_as_toplevel(true)
			$InventoryMenuHolder/Canvas.add_child(inv)
			inv.setInventory($InventoryManager)
		$InventoryTimer.start()

func changeSkin():
	var skin = SaveSystem.GetValue("current_skin")
	mySkinItem = ItemLoader.GetItem(skin)
	if mySkinItem == null:
		$Body/AnimatedSprite.animation = "ned_normal"
	else:
		passive_doots =[mySkinItem.lower_passive_doots, mySkinItem	.upper_passive_doots]
		speed_bonus = mySkinItem.speed_bonus*speed
		$Body/AnimatedSprite.animation = mySkinItem.item_skin_name

func changeWeapon():
	var wep = SaveSystem.GetValue("current_weapon")
	var itm = ItemLoader.GetItem(wep)
	if itm == null:
		$Body/Weapon_Holder/Weapon_Base.setWeapon(ItemLoader.GetItem(2001))
	else:
		weaponDamage =[itm.lower_weapon_damage, itm.upper_weapon_damage]
		weaponCrit = itm.weapon_crit
		$Body/Weapon_Holder/Weapon_Base.setWeapon(itm)

func GetHitData():
	rng.randomize()
	var my_dmg = rng.randf_range(weaponDamage[0], weaponDamage[1])
	var crit_chance = rng.randf_range(0,1)
	if weaponCrit >= crit_chance:
		my_dmg = (round(my_dmg + my_dmg*0.7))
		return [my_dmg, 1]
	else:
		return [my_dmg, 0]

func _on_InventoryTimer_timeout():
	canToggleInventory = true
