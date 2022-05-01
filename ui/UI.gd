extends Control

#const SlotClass = preload("res://ui/InventorySlot.gd")

onready var gold: Label = get_node("GoldLabel")
onready var inventory_slots = $BuildingBar/HBoxContainer

var holding_item = null

var index_to_object : Dictionary = {
	0: TorchItem,
	1: MineItem
}


func _ready() -> void:
	Player.connect("GoldUpdated", self, "update_interface")
	update_interface()
	for inv_slot in inventory_slots.get_children():
		print(inv_slot)
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot])
		index_to_object
	
	

func slot_gui_input(event: InputEvent, slot: InventorySlot):
	
	
	# clicking the menu
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			print("clicked panel: %s with index %s" % [slot, slot.get_index()])
			
			#if holding item
			if holding_item != null:
				pass
#				if !slot.item: # place holding item to slot
#					slot.putIntoSlot(holding_item)
#					holding_item = null
#				else: # swap holding item with item in slot
#
#					if holding_item.item_name != slot.item.item_name:
#						var temp_item = slot.item
#						slot.pickFromSlot()
#						temp_item.global_position = event.global_position
#						slot.putIntoSlot(holding_item)
#						holding_item = temp_item
#
#					else:
#						var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
#						var able_to_add = stack_size - slot.item.item_quantity
#						if able_to_add >= holding_item.item_quantity:
#							slot.item.add_item_quantity(holding_item.item_quantity)
#							holding_item.queue_free()
#							holding_item = null
#						else:
#							slot.item.add_item_quantity(able_to_add)
#							holding_item.decrease_item_quantity(able_to_add)

			# not holding an item
			elif slot.get_child_count() > 0:
				holding_item = slot.generate_slot_item()
				print(holding_item)
				print(holding_item.get_children())
#				var my_index = slot.get_index()
#				if index_to_object.has(my_index):
#					holding_item = index_to_object[my_index].new()
##				print(slot.get_child(0))
##				holding_item = slot.ItemClass.instance()
				add_child(holding_item)
				holding_item.global_position = get_global_mouse_position().snapped(Vector2(32,32))


func _toggle_building_bar():
	$BuildingBar.visible = !$BuildingBar.visible

func _input(event: InputEvent) -> void:
	
	if holding_item:
		holding_item.get_child(0).scale = SignalBus.current_zoom
		# TODO this is not working like I wish :(
		holding_item.global_position = get_global_mouse_position().snapped(Vector2(32,32))
		
	# Show / Hide the menu with Q
	if event.is_action_pressed("building_menu"):
		_toggle_building_bar()

func update_interface() -> void:
	gold.text = "Gold: %s" % Player.gold

