extends Control

func _ready():
	update_doot_value() 

func update_doot_value():
	var totalDoots = (SaveSystem.GetValue("doot_count"))
	var exoticDoots = (totalDoots/10000000000)
	var upDoots = ((totalDoots % 10000000000)/100000)
	var doots = totalDoots - exoticDoots*10000000000 - upDoots*100000
	
	$Canvas/BarContainer/ExoticDoot/ExoticLabel.text = PrettyNumbers.GetPrettyNumber(exoticDoots)
	$Canvas/BarContainer/Updoot/UpLabel.text = PrettyNumbers.GetPrettyNumber(upDoots)
	$Canvas/BarContainer/Doot/DootLabel.text = PrettyNumbers.GetPrettyNumber(doots)


func _on_Town_update_doot_value():
	update_doot_value()
