extends Control

func _ready():
	update_doot_value() 

func update_doot_value():
	$Label.text = str(SaveSystem.GetValue("doot_count"))


func _on_Cofalt_update_doot_value():
	update_doot_value() 
