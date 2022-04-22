extends Node2D

onready var roomManager = preload("res://scenes/RoomManager.tscn")
onready var rm : Node = roomManager.instance()

onready var torch = preload("res://scenes/objects/Torch.tscn")


export var DEBUG = false
export var torch_sprite : Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(rm)
	if DEBUG:
		Player.gold += 9999


# this code places torches with "Q"
func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and DEBUG:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var mouse_position = get_global_mouse_position()
			var snapped_mouse = mouse_position.snapped(Vector2(256,256))
			if rm.positionToCell.has(snapped_mouse):
				var cell = rm.positionToCell[snapped_mouse]
				var local_position = cell.to_local(mouse_position)
				var map_position = cell.get_child(0).world_to_map(local_position)

				
				local_position = cell.get_child(0).map_to_world(map_position)
				var global_position = cell.get_child(0).to_global(local_position)


				print("map")
				print(map_position)
				print("")
				print(global_position)
				print("")
	if event.is_action_pressed("menu"):
		if $GUI/Menu.visible:
			$GUI/Menu.hide()
		else:
			$GUI/Menu.show()
	
	if event.is_action_pressed("place_torch"):
		var mouse_position = get_global_mouse_position()
		var snapped_mouse = mouse_position.snapped(Vector2(256,256))
		if rm.positionToCell.has(snapped_mouse):
			var cell = rm.positionToCell[snapped_mouse]
			if !cell.is_lighted or true:
				# some position transformation fuckery
				var local_position = cell.to_local(mouse_position)
				var map_position = cell.get_child(0).world_to_map(local_position)
				local_position = cell.get_child(0).map_to_world(map_position)
				var global_position = cell.get_child(0).to_global(local_position)
				
				var new_torch = torch.instance()
				new_torch.position = cell.to_local(global_position) + Vector2(16,16)
				cell.add_child(new_torch)


func _on_Timer_timeout() -> void:
	Player.gold += 15 * Player.gold_structures

func _on_Back_pressed() -> void:
	$GUI/Menu.hide()

func _on_NewGame_pressed() -> void:
	get_tree().change_scene("res://Main.tscn")


func _on_Options_pressed() -> void:
	var options = load("res://userInterface/Options.tscn").instance()
	$GUI.add_child(options)
