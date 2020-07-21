extends Node


func GetPrettyNumber(num: int):
	if num < 1000: # None
		return str(num)
	elif num >= 1000 and num < 999999:
		var x = str(stepify(num/1000.0, 0.1))+'K'
		return str(x)
	elif num >= 1000000 and num < 1000000000:
		var x = str(stepify(num/1000000.0, 0.1))+'M'
		return str(x)
	elif num >= 1000000000 and num < 1000000000000:
		var x = str(stepify(num/1000000000.0, 0.1))+'B'
		return str(x)
	elif num >= 1000000000000:
		var x = str(stepify(num/1000000000000.0, 0.1))+'T'
		return str(x)
