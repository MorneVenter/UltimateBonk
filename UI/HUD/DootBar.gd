extends Control

func _ready():
	update_doot_value() 

func update_doot_value():
	# 100k Doots = 1 Updoot
	# 100k Updoots = 1 Exotic Doot
	
	var totalDoots = (SaveSystem.GetValue("doot_count"))
	var pret_doots = PrettyNumbers.GetPrettyDootCount(totalDoots)
	var exoticDoots = pret_doots[0]
	var upDoots = pret_doots[1]
	var doots = pret_doots[2]
	
	$Canvas/BarContainer/ExoticDoot/ExoticLabel.text = PrettyNumbers.GetPrettyNumber(exoticDoots)
	$Canvas/BarContainer/Updoot/UpLabel.text = PrettyNumbers.GetPrettyNumber(upDoots)
	$Canvas/BarContainer/Doot/DootLabel.text = PrettyNumbers.GetPrettyNumber(doots)


func _on_Town_update_doot_value():
	update_doot_value()
