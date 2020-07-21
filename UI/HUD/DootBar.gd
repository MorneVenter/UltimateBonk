extends Control

func _ready():
	update_doot_value() 

func update_doot_value():
	var totalDoots = SaveSystem.GetValue("doot_count")
	var exoticDoots = int(totalDoots/1000000)
	var upDoots = int((totalDoots % 1000000)/1000)
	var doots = totalDoots - exoticDoots*1000000 - upDoots*1000
	
	$Canvas/BarContainer/ExoticDoot/ExoticLabel.text = str(exoticDoots)
	$Canvas/BarContainer/Updoot/UpLabel.text = str(upDoots)
	$Canvas/BarContainer/Doot/DootLabel.text = str(doots)


func _on_Town_update_doot_value():
	update_doot_value()
