extends Node2D
export var speed = 100
var lerpStart = 0.2
var lerpCoficient = lerpStart
var facing_direction= 1
var isAttacking = false

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("hit_controller") and not isAttacking:
		hit()
	
func _physics_process(delta):
	if not isAttacking:
		movePlayer()

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
		if event.position.x >= $Body.global_position.x:
			$Body/AnimatedSprite.flip_h = false
			facing_direction = 1
		else:
			$Body/AnimatedSprite.flip_h = true
			facing_direction = -1
		hit()

func movePlayer():
	var dir = get_direction()*lerpCoficient
	$Body.move_and_slide(dir*speed)
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
	elif facing_direction == -1:
		$AnimationPlayer.current_animation = "hit_left"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit_left" or anim_name == "hit_right":
		isAttacking = false
