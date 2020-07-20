extends Node2D


func _ready():
	$AnimationPlayer.current_animation = 'idle'

func _on_TriggerArea_area_entered(area):
	if area.name == "PlayerHitLeft":
		var player = area.get_owner()
		$AnimationPlayer.current_animation = "hit_left"
		hit(player.getHitData())
	elif area.name == "PlayerHitRight":
		var player = area.get_owner()
		$AnimationPlayer.current_animation = "hit_right"
		hit(player.getHitData())


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit_left" or anim_name == "hit_right":
		$AnimationPlayer.current_animation = "idle"

func hit(hitData):
	var dmg = int(hitData[0])
	var crit = int(hitData[1])
	var has_crit = true if crit==1 else false
	var disp_string = '+' + str(dmg)
	$FloatingTextManager.showValue(disp_string, has_crit)
	get_parent().addDoots(dmg)
