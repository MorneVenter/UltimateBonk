extends TextureRect

var myTexture: Texture = null
var itemID: int = -1
export var non_clickable = false

func clear():
	myTexture = null
	itemID = -1 # error value, is empty.
	$DisplayItem.texture = null

func setItem(tex: Texture, id: int):
	itemID = id
	myTexture = tex
	$DisplayItem.texture = myTexture


func _on_Button_pressed():
	if non_clickable == false:
		print("pressed")
