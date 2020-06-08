extends Node2D
signal update_doot_value

func _ready():
	$AnimationPlayer.current_animation = 'idle'

func _on_TriggerArea_area_entered(area):
	if area.name == "PlayerHitLeft":
		$AnimationPlayer.current_animation = "hit_left"
		hit()
	elif area.name == "PlayerHitRight":
		$AnimationPlayer.current_animation = "hit_right"
		hit()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit_left" or anim_name == "hit_right":
		$AnimationPlayer.current_animation = "idle"

func hit():
	$FloatingTextManager.showValue('+1', false)
	var new_v = int(SaveSystem.GetValue("doot_count")) + 1
	SaveSystem.StoreValue("doot_count", new_v)
	emit_signal("update_doot_value")
