
class_name InventorySlot extends Panel


onready var my_index = get_index()
#var ItemClass = null
#var item = null
#var slot_index

onready var Torch = preload("res://scenes/objects/torch/Torch.tscn")
onready var Mine = preload("res://scenes/objects/mine/Mine.tscn")

# TODO make this simpler. have a sprite instead of item. have a dictionary

onready var index_to_object : Dictionary = {
	0: Torch,
	1: Mine
}

func _ready() -> void:
	pass
	
func generate_slot_item():
	if index_to_object.has(my_index):
		print(index_to_object[get_index()])
		return index_to_object[get_index()].instance()
	else:
		return -1

#func _input(event: InputEvent) -> void:
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			item = ItemClass.instance()
	
#func pickFromSlot():
#	remove_child(item)
#	var inventoryNode = find_parent("Inventory")
#	inventoryNode.add_child(item)
#	item = null
#	refresh_style()
#
#func putIntoSlot(new_item):
#	item = new_item
#	item.position = Vector2(0,0)
#	var inventoryNode = find_parent("Inventory")
#	inventoryNode.remove_child(item)
#	add_child(item)
#	refresh_style()
