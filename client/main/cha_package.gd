extends Node

var package_num = 0
var package_items = []

# character package info
func _ready():
	for i in range(package_num):
		var item = {"item" : -1, "num" : 0}
		package_items.append(item)

func add_item(id, num):
	pass