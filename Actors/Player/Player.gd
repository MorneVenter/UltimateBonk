extends Node2D
export var speed = 100
var lerpStart = 0.2
var lerpCoficient = lerpStart

func _ready():
	pass

func _process(delta):
	pass
	
func _physics_process(delta):
	var dir = get_direction()*lerpCoficient
	$KinematicBody2D.move_and_slide(dir*speed)
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
		$KinematicBody2D/AnimatedSprite.flip_h = true
	elif right == 1:
		$KinematicBody2D/AnimatedSprite.flip_h = false
	return Vector2(x,y).normalized()
