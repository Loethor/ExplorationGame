extends Node

# Base room
onready var baseCell = preload("res://scenes/rooms/BaseCell.tscn")
onready var hiddenLayer = preload("res://scenes/HiddenLayer.tscn")

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
							topRightLeftCell, topBottomLeftCell, bottomRightLeftCell]

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


onready var positionToCell : Dictionary = {}

var origin : Vector2 = Vector2.ZERO
var UnsurroundedCells : Array
var SurroundedCells : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("SurroundRequired", self, "_surround_cells")
	_create_origin_cell()
	
func _create_origin_cell()->void:
	var origin_cell : Node2D =  _create_cell(origin, baseCell)
	UnsurroundedCells.append(origin_cell)
	origin_cell.add_gold_generator()
	origin_cell.activate_structures()
	_surround_cells(origin_cell)

func _create_cell(pos:Vector2, kind_of_cell:PackedScene)->Object:
	var new_cell = kind_of_cell.instance()
	new_cell.init(pos)
	positionToCell[pos] = new_cell	
	add_child(new_cell)
	return new_cell
	
func _add_cover_to_cell(cell:Object)->Object:
	var hidden_layer = hiddenLayer.instance()
	cell.add_child(hidden_layer)
	return cell
	
func _add_structures_to_cell(cell:Object)->Object:
	#TODO add more structures
	if randi()%100 < SignalBus.gold_chance:
			cell.add_gold_generator()
	return cell
	
func _create_covered_cell_on_pos(pos:Vector2, kind_of_cell:PackedScene)->Object:
	var new_cell : Object = _create_cell(pos, kind_of_cell)
	new_cell = _add_cover_to_cell(new_cell)
	new_cell = _add_structures_to_cell(new_cell)
	return new_cell
	
func _surround_cells(cell:Object)->void:
	var pos = cell.position
	
	var top_pos : Vector2 = Vector2(pos.x, pos.y - SignalBus.CELL_SIZE)
	var bot_pos : Vector2 = Vector2(pos.x, pos.y + SignalBus.CELL_SIZE)
	var left_pos : Vector2 = Vector2(pos.x - SignalBus.CELL_SIZE, pos.y)
	var right_pos : Vector2 = Vector2(pos.x + SignalBus.CELL_SIZE, pos.y)
	
	#TODO add logic to other rooms
	#########
	
	
	
	
	#########
	var new_cell_type:PackedScene
	# if the dictionary doesn't have the position
	if !positionToCell.has(top_pos):
		if cell.has_top_wall:
			new_cell_type = Utils.random_from_array(contains_bottom_wall)	
		else:
			new_cell_type = Utils.random_from_array(missing_bottom_wall)	
		_create_covered_cell_on_pos(top_pos, new_cell_type)

	if !positionToCell.has(bot_pos):
		if cell.has_bottom_wall:
			new_cell_type = Utils.random_from_array(contains_top_wall)	
		else:
			new_cell_type = Utils.random_from_array(missing_top_wall)	
		_create_covered_cell_on_pos(bot_pos, new_cell_type)

	if !positionToCell.has(left_pos):
		if cell.has_left_wall:
			new_cell_type = Utils.random_from_array(contains_right_wall)	
		else:
			new_cell_type = Utils.random_from_array(missing_right_wall)	
		_create_covered_cell_on_pos(left_pos, new_cell_type)

	if !positionToCell.has(right_pos):
		if cell.has_right_wall:
			new_cell_type = Utils.random_from_array(contains_left_wall)	
		else:
			new_cell_type = Utils.random_from_array(missing_left_wall)	
		_create_covered_cell_on_pos(right_pos, new_cell_type)
	
	return
