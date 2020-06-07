extends Node2D


func _ready():
	$AnimationPlayer.current_animation = 'idle'




func _on_TriggerArea_area_entered(area):
	if area.name == "PlayerHitLeft":
		$AnimationPlayer.current_animation = "hit_left"
	elif area.name == "PlayerHitRight":
		$AnimationPlayer.current_animation = "hit_right"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit_left" or anim_name == "hit_right":
		$AnimationPlayer.current_animation = "idle"
