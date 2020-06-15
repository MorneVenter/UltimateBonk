extends Label
export var critColor: Color

func showValue(value, travel, duration, spread, crit = false):
	text = value
	var movement = travel.rotated(rand_range(-spread/2, spread/2))
	rect_pivot_offset = rect_size/2
	
	$Tween.interpolate_property(
		self, 
		"rect_position", 
		rect_position, 
		rect_position+movement, 
		duration, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_OUT)
	if crit:
		modulate = critColor
		$Tween.interpolate_property(self, "rect_scale",
			rect_scale*2, rect_scale,
			0.4, Tween.TRANS_BACK, Tween.EASE_IN)
			
	$Tween.start()
	yield($Tween, "tween_all_completed")
	queue_free()
	
