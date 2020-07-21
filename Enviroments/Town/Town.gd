extends Node2D
signal update_doot_value

func AddDoots(amount: int):
	var new_v = int(SaveSystem.GetValue("doot_count")) + amount
	SaveSystem.StoreValue("doot_count", new_v)
	emit_signal("update_doot_value")
