extends Control

func _ready():
	checkSaveExists()


func checkSaveExists():
	var s1 = Directory.new();
	var s1Exist = s1.file_exists("user://savedata/save_001.save")
	
	var s2 = Directory.new();
	var s2Exist = s2.file_exists("user://savedata/save_002.save")
	
	var s3 = Directory.new();
	var s3Exist = s3.file_exists("user://savedata/save_003.save")
	
	if s1Exist:
		$Saves/SavesContainer/Save1Button/Status.text = '<Load Game>'
	if s2Exist:
		$Saves/SavesContainer/Save2Button/Status.text = '<Load Game>'
	if s3Exist:
		$Saves/SavesContainer/Save3Button/Status.text = '<Load Game>'

func loadGame(slotNumber):
	SaveSystem.id = slotNumber
	SaveSystem._loadData()
	get_tree().change_scene("res://Enviroments/Town/Town.tscn")
	
func deleteSave(slotNumber):
	var sav = Directory.new();
	var path = "user://savedata/save_00%.save"
	path = path.replace("%", str(slotNumber))
	var sExist = sav.file_exists(path)
	if sExist:
		sav.remove(path)
		if slotNumber == 1:
			$Saves/SavesContainer/Save1Button/Status.text = '<Empty>'
		elif slotNumber == 2:
			$Saves/SavesContainer/Save2Button/Status.text = '<Empty>'
		elif slotNumber == 3:
			$Saves/SavesContainer/Save3Button/Status.text = '<Empty>'		

func _on_BackButton_pressed():
	get_tree().change_scene("res://UI/MainMenu/TitleScreen.tscn")

func _on_Save1Button_pressed():
	loadGame(1)

func _on_Save2Button_pressed():
	loadGame(2)

func _on_Save3Button_pressed():
	loadGame(3)


func _on_DeleteButton1_pressed():
	deleteSave(1)


func _on_DeleteButton2_pressed():
	deleteSave(2)


func _on_DeleteButton3_pressed():
	deleteSave(3)
