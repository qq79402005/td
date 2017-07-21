extends Node

var items = Array()

class Item:
	var id = 0
	var name = String("")
	var type = String("")
	var icon = String("")
	var res  = String("")
	var res_load = null
	
	func _init():
		pass

func _ready():
	var parser = XMLParser.new()
	parser.open("res://global/cfg/items.xml")
	while not parser.read():
		if parser.get_node_type()==XMLParser.NODE_ELEMENT and "item" == parser.get_node_name():
			var item = Item.new()
			for i in range(parser.get_attribute_count()):
				var att_name = parser.get_attribute_name(i)
				if att_name == "id":
					item.id = parser.get_attribute_value(i).to_int()
				elif att_name == "name":
					item.name = parser.get_attribute_value(i)
				elif att_name == "type":
					item.type = parser.get_attribute_value(i)
				elif att_name == "icon":
					item.icon = parser.get_attribute_value(i)
				elif att_name == "res":
					item.res = parser.get_attribute_value(i)
					item.res_load = load(item.res)
		
			items.append(item)
	
func get_item_count():
	return items.size()
	
func get_item_by_index( idx):
	return items[idx]

func get_item_icon( id):
	pass
	
	
