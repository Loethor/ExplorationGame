extends Node

# Base room
onready var baseCell = preload("res://scenes/rooms/BaseCell.tscn")

### Other rooms

# Single wall rooms
onready var topCell = preload("res://scenes/rooms/TopCell.tscn")
onready var bottomCell = preload("res://scenes/rooms/BottomCell.tscn")
onready var leftCell = preload("res://scenes/rooms/LeftCell.tscn")
onready var rightCell = preload("res://scenes/rooms/RightCell.tscn")


# Double wall rooms

onready var topRightCell = preload("res://scenes/rooms/TopRightCell.tscn")
onready var topLeftCell = preload("res://scenes/rooms/TopLeftCell.tscn")
onready var bottomRightCell = preload("res://scenes/rooms/BottomRightCell.tscn")
onready var bottomLeftCell = preload("res://scenes/rooms/BottomLeftCell.tscn")


# Triple wall rooms

onready var bottomRightLeftCell = preload("res://scenes/rooms/BottomRightLeftCell.tscn")
onready var topRightLeftCell = preload("res://scenes/rooms/TopRightLeftCell.tscn")
onready var topBottomLeftCell = preload("res://scenes/rooms/TopBottomLeftCell.tscn")
onready var topBottomRightCell = preload("res://scenes/rooms/TopBottomRightCell.tscn")



# Empty room

onready var emptyCell = preload("res://scenes/rooms/EmptyCell.tscn")

### Arrays of cells

# list of all cells (why not?)
onready var all_cells = [baseCell,
						topCell, bottomCell, leftCell, rightCell,
						topRightCell, topLeftCell, bottomRightCell, bottomLeftCell,
						bottomRightLeftCell, topRightLeftCell, topBottomLeftCell, topBottomRightCell,
						emptyCell]

# list of cells without right wall
onready var missing_right_wall = [topCell, bottomCell, leftCell, 
							topLeftCell, bottomLeftCell,
							topBottomLeftCell, emptyCell]

# list of cells without left wall
onready var missing_left_wall = [topCell, bottomCell, rightCell, 
							topRightCell, bottomRightCell,
							topBottomRightCell, emptyCell]

# list of cells without top wall
onready var missing_top_wall = [bottomCell, leftCell, rightCell, 
							bottomLeftCell, bottomRightCell,
							bottomRightLeftCell, emptyCell]

# list of cells without bottom wall
onready var missing_bottom_wall = [topCell, leftCell, rightCell, 
							topRightCell, topLeftCell,
							topRightLeftCell, emptyCell]

# list of cells with right wall
onready var contains_right_wall = [rightCell, 
							topRightCell, bottomRightCell,
							topRightLeftCell, topBottomRightCell, bottomRightLeftCell]

# list of cells with left wall
onready var contains_left_wall = [leftCell,  
							topLeftCell, bottomLeftCell,
							topBottomLeftCell, topRightLeftCell, bottomRightLeftCell]

# list of cells with top wall
onready var contains_top_wall = [topCell, 
							topLeftCell, topRightCell,
							topBottomRightCell, topBottomLeftCell, topRightLeftCell]

# list of cells with bottom wall
onready var contains_bottom_wall = [bottomCell, 
							bottomLeftCell, bottomRightCell,
							bottomRightLeftCell, topBottomLeftCell, topBottomRightCell]


## further filters

onready var cells_two_walls = [topLeftCell, topRightCell, bottomLeftCell, bottomRightCell]
onready var cells_three_walls = [bottomRightLeftCell, topRightLeftCell, topBottomLeftCell, topBottomRightCell]

onready var positionToCell : Dictionary = {}
onready var roomIdToCells : Dictionary = {}

var origin : Vector2 = Vector2.ZERO

var room_count := 0 setget set_room_count
var cost_to_unlock := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_cost()
	SignalBus.connect("DoorOpened", self, "_create_adjacent_cell")
	_create_origin_cell()

func set_room_count(value:int):
	print('updating room count')
	room_count = value
	var new_cost = _update_cost()
	SignalBus.emit_signal('UpdateLabels')

func _update_cost():
	cost_to_unlock = room_count * 5  - 4
	return cost_to_unlock
	
func _create_origin_cell()->void:
	
	var origin_cell : Node2D =  _create_cell(origin, baseCell, room_count)
	print(room_count)
	self.room_count += 1
	print(room_count)

	origin_cell.light_on()
	origin_cell.add_gold_generator()
	origin_cell.activate_structures()

	
func _create_adjacent_cell(cell, type_of_door, where=Vector2.ZERO, id=null):
	
	var pos:Vector2 = cell.get_position()
	var neighbor_positions : Array = _calculate_neigh_positions(pos) 
	
	var new_pos:Vector2
	var fun = "_do_nothing"
	if id == null:
		id = room_count
		self.room_count+=1
	
	if where == Vector2.ZERO:
		if type_of_door == "top":
			new_pos = neighbor_positions[0]
			fun = "_open_bottom"
		elif type_of_door == "bottom":
			new_pos = neighbor_positions[1]
			fun = "_open_top"		
		elif type_of_door == "left":
			new_pos = neighbor_positions[2]
			fun = "_open_right"
		elif type_of_door == "right":
			new_pos = neighbor_positions[3]
			fun = "_open_left"
		else:
			fun = "_do_nothing"
	else:
		new_pos = where
	if positionToCell.has(new_pos):
		return
		
		
	# Before generating a cell at new_pos, lets check its neighbors
	var neighbor_neighbor_positions:Array = _calculate_neigh_positions(new_pos)
	
	var intersect_array:Array = all_cells
	
	# check top cell
	if positionToCell.has(neighbor_neighbor_positions[0]):
		if positionToCell[neighbor_neighbor_positions[0]].has_bottom_wall:
			intersect_array =_intersect_two_arrays(intersect_array, contains_top_wall) 
		else:
			intersect_array =_intersect_two_arrays(intersect_array, missing_top_wall)  
	# check bottom cell
	if positionToCell.has(neighbor_neighbor_positions[1]):
		if positionToCell[neighbor_neighbor_positions[1]].has_top_wall:
			intersect_array =_intersect_two_arrays(intersect_array, contains_bottom_wall) 
		else:
			intersect_array =_intersect_two_arrays(intersect_array, missing_bottom_wall)  
	# check left cell
	if positionToCell.has(neighbor_neighbor_positions[2]):
		if positionToCell[neighbor_neighbor_positions[2]].has_right_wall:
			intersect_array =_intersect_two_arrays(intersect_array, contains_left_wall) 
		else:
			intersect_array =_intersect_two_arrays(intersect_array, missing_left_wall)  
	# check right cell
	if positionToCell.has(neighbor_neighbor_positions[3]):
		if positionToCell[neighbor_neighbor_positions[3]].has_left_wall:
			intersect_array =_intersect_two_arrays(intersect_array, contains_right_wall) 
		else:
			intersect_array =_intersect_two_arrays(intersect_array, missing_right_wall)  

	
	var cells_to_choose:Array = _intersect_two_arrays(all_cells, intersect_array)
	if(where != Vector2.ZERO):
		var reduced_cells_to_choose
		if randi()%10 < 5 :
			reduced_cells_to_choose = _intersect_two_arrays(cells_to_choose, cells_three_walls+cells_two_walls+[emptyCell] )
		else:
			reduced_cells_to_choose = _intersect_two_arrays(cells_to_choose, cells_three_walls)
			if reduced_cells_to_choose == []:
				reduced_cells_to_choose = _intersect_two_arrays(cells_to_choose, cells_two_walls)
		if reduced_cells_to_choose != []:
			cells_to_choose = reduced_cells_to_choose
	
	var new_cell_type:PackedScene = Utils.random_from_array(cells_to_choose)
	
		
	
	# create cell and open its door
	var new_cell = _create_cell(new_pos, new_cell_type, id)
	new_cell.call(fun)
	SignalBus.emit_signal('UpdateLabels')
	
	
	
	# open all doors for new cells TODO only when lighting
	# top
	if positionToCell.has(neighbor_neighbor_positions[0]):
		if positionToCell[neighbor_neighbor_positions[0]].has_bottom_wall:
			positionToCell[neighbor_neighbor_positions[0]]._open_bottom()
			new_cell._open_top()
			
	if positionToCell.has(neighbor_neighbor_positions[1]):
		if positionToCell[neighbor_neighbor_positions[1]].has_top_wall:
			positionToCell[neighbor_neighbor_positions[1]]._open_top()
			new_cell._open_bottom()
			
	if positionToCell.has(neighbor_neighbor_positions[3]):
		if positionToCell[neighbor_neighbor_positions[3]].has_left_wall:
			positionToCell[neighbor_neighbor_positions[3]]._open_left()
			new_cell._open_right()
			
	if positionToCell.has(neighbor_neighbor_positions[2]):
		if positionToCell[neighbor_neighbor_positions[2]].has_right_wall:
			positionToCell[neighbor_neighbor_positions[2]]._open_right()
			new_cell._open_left()		
					
	
	# TODO new cells without walls
	if !new_cell.has_top_wall and !positionToCell.has(neighbor_neighbor_positions[0]):
		_create_adjacent_cell(new_cell, "no door", neighbor_neighbor_positions[0], id)
	# TODO new cells without walls
	if !new_cell.has_bottom_wall and !positionToCell.has(neighbor_neighbor_positions[1]):
		_create_adjacent_cell(new_cell, "no door", neighbor_neighbor_positions[1], id)
	# TODO new cells without walls
	if !new_cell.has_left_wall and !positionToCell.has(neighbor_neighbor_positions[2]):
		_create_adjacent_cell(new_cell, "no door", neighbor_neighbor_positions[2], id)
	# TODO new cells without walls
	if !new_cell.has_right_wall and !positionToCell.has(neighbor_neighbor_positions[3]):
		_create_adjacent_cell(new_cell, "no door", neighbor_neighbor_positions[3], id)



func _create_cell(pos:Vector2, kind_of_cell:PackedScene, id:int)->Object:
	var new_cell = kind_of_cell.instance()
	new_cell.set_position(pos)
	add_child(new_cell)
	new_cell.init(id)
	
	# add cell to dictionary of positions
	positionToCell[pos] = new_cell
	
	# add cell to dictionary of rooms
	if roomIdToCells.has(id):
		roomIdToCells[id].append(new_cell)
	else:
		roomIdToCells[id] = [new_cell]

		
	return new_cell
	
func _add_structures_to_cell(cell:Object)->Object:
	#TODO add more structures
	if randi()%100 < SignalBus.gold_chance:
			cell.add_gold_generator()
	return cell
	
func _intersect_two_arrays(arrayA:Array, arrayB:Array)->Array:
	var arrayC : Array
	if arrayA.size() > 0 and arrayB.size() > 0:
		arrayC = Utils.intersect_arrays(arrayA, arrayB)
	else:
		if arrayA.size() > arrayB.size():
			arrayC = arrayA
		elif arrayB.size() > arrayA.size():
			arrayC = arrayB
	return arrayC
			

#func check_neighbor_cell(cell:Object, neigh_position:Vector2,
#						 wall_to_check, contains_array:Array,
#						missing_array:Array):
#	var new_cell_type:PackedScene						
#	if cell.wall_to_check:
#		new_cell_type = Utils.random_from_array(contains_array)
#	else:
#		new_cell_type = Utils.random_from_array(missing_array)
#
		
func _calculate_neigh_positions(pos:Vector2):
	var top_pos : Vector2 = Vector2(pos.x, pos.y - SignalBus.CELL_SIZE)
	var bot_pos : Vector2 = Vector2(pos.x, pos.y + SignalBus.CELL_SIZE)
	var left_pos : Vector2 = Vector2(pos.x - SignalBus.CELL_SIZE, pos.y)
	var right_pos : Vector2 = Vector2(pos.x + SignalBus.CELL_SIZE, pos.y)
	return [top_pos, bot_pos, left_pos, right_pos]


