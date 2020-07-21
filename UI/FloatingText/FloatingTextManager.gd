extends Node2D

var FCT = preload("./FCT.tscn")

export var travel = Vector2(0,-80)
export var duration = 1.5
export var spread = PI/2

func showValue(value, crit):
	var fct = FCT.instance()
	add_child(fct)
	fct.showValue(str(value), travel, duration, spread, crit)
