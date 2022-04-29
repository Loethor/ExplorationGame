extends Panel


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var ItemClass = null
var item = null
var slot_index


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item = get_child(0)
	ItemClass = load(item.path)

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
