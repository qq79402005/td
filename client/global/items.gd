extends Node

var items = Array()

class Item:
	var id = 0
	var icon = Texture("")
	var res  = String("")
	
	func _init():
		pass

func _ready():
	var parser = XMLParser.new()
	parser.open("res://global/cfg/items.xml")
	while not parser.read():
		if "item" == parser.get_node_name():
			for i in range(parser.get_attribute_count()):
				var att_name = parser.get_attribute_name(i)
				if att_name == "res":
					var att_value = parser.get_attribute_value(i)
					print(att_name, ":", att_value)
					#items.append(Item.new())
					
	#print(items.size())
	
func get_item_icon( id):
	pass
