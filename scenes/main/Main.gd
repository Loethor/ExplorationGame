extends Node2D

onready var roomManager = preload("res://scenes/RoomManager.tscn")
onready var rm : Node = roomManager.instance()

onready var torch = preload("res://scenes/objects/torch/Torch.tscn")


export var DEBUG = false
export var torch_sprite : Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(rm)
	if DEBUG:
		Player.gold += 9999


# this code places torches with "Q"
func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("menu"):
		if $GUI/Menu.visible:
			$GUI/Menu.hide()
		else:
			$GUI/Menu.show()
	
	if event is InputEventMouseButton and DEBUG:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var mouse_position = get_global_mouse_position()
			var snapped_mouse = Utils.step_vector_to(mouse_position, 256)
			print("Global mouse position: %s" % mouse_position)
			print("Snapped mouse position: %s" % snapped_mouse)
			
			if rm.positionToCell.has(snapped_mouse):
				var cell = rm.positionToCell[snapped_mouse]
				
				# position inside cell coordinates
				var local_position = cell.to_local(mouse_position)
				
				#position of the tile in the tileset
				var map_position = cell.get_child(0).world_to_map(local_position)
				print(cell.get_child(0).get_cellv(map_position))

				print("Cell in the grid: %s" % cell.grid_position)
				print("Local position in the cell: %s" % local_position)
				
				# returns it to world (still local)
				local_position = cell.get_child(0).map_to_world(map_position)

				#local to global
				var global_position = cell.to_global(local_position)

				print("Local position in the cell: %s" % local_position)
				print("Global position in the cell: %s" % global_position)	
	
#	TODO probably can be changed with a mouse hovering on the cell and a static body (on mouse entered...)
	if event.is_action_pressed("place_torch"):
		var mouse_position = get_global_mouse_position()
		var snapped_mouse = Utils.step_vector_to(mouse_position, 256)
		if rm.positionToCell.has(snapped_mouse):
			var cell = rm.positionToCell[snapped_mouse]
			if !cell.is_lighted or true:
				# some position transformation fuckery
				var local_position = cell.to_local(mouse_position)
				var tilemap = cell.get_child(0)
				var map_position = tilemap.world_to_map(local_position)
				if tilemap.get_cellv(map_position) == 21:
					local_position = tilemap.map_to_world(map_position)
					var global_position = cell.to_global(local_position)
					
					var new_torch = torch.instance()
					new_torch.position = cell.to_local(global_position)
					cell.add_child(new_torch)
					cell.light_on()


func _on_Timer_timeout() -> void:
	Player.gold += 15 * Player.gold_structures

func _on_ResumeGame_pressed() -> void:
	$GUI/Menu.hide()

func _on_RestartGame_pressed() -> void:
	# TODO restart game values
	get_tree().change_scene("res://scenes/main/Main.tscn")

func _on_Options_pressed() -> void:
	var options = load("res://menus/Options.tscn").instance()
	$GUI.add_child(options)

func _on_MainMenu_pressed() -> void:
	# TODO add confirmation
	get_tree().change_scene("res://menus/MainMenu.tscn")

func _on_QuitToDesktop_pressed() -> void:
	get_tree().quit()
