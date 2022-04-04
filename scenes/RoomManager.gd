extends Node

onready var baseCell = preload("res://scenes/rooms/BaseCell.tscn")
onready var hiddenLayer = preload("res://scenes/HiddenLayer.tscn")


onready var positionToCell : Dictionary = {}

var origin : Vector2 = Vector2.ZERO
var UnsurroundedCells : Array
var SurroundedCells : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("SurroundRequired", self, "_surround_cells")
	_create_origin_cell()
	
func _create_origin_cell()->void:
	positionToCell[origin] = _create_cell(origin)
	UnsurroundedCells.append(positionToCell[origin])
	positionToCell[origin].add_gold_generator()
	positionToCell[origin].activate_structures()
	_surround_cells(positionToCell[origin])

func _create_cell(pos:Vector2)->Object:
	var ec = baseCell.instance()
	ec.init(pos)
	add_child(ec)
	return ec
#
func _create_covered_cell_on_pos(pos:Vector2)->Object:
	var new_cell:Object = _create_cell(pos)
	
	var hidden_layer = hiddenLayer.instance()
	new_cell.add_child(hidden_layer)
	
	positionToCell[pos] = new_cell
	if randi()%100 < SignalBus.gold_chance:
			new_cell.add_gold_generator()
	return new_cell

	
func _surround_cells(cell:Object)->void:
	var pos = cell.position
	var top_pos:Vector2 = Vector2(pos.x,pos.y-128)
	var bot_pos:Vector2 = Vector2(pos.x,pos.y+128)
	var left_pos:Vector2 = Vector2(pos.x-128,pos.y)
	var right_pos:Vector2 = Vector2(pos.x+128,pos.y)
	

	# if the dictionary doesn't have the position
	if !positionToCell.has(top_pos):
		_create_covered_cell_on_pos(top_pos)

	if !positionToCell.has(bot_pos):
		_create_covered_cell_on_pos(bot_pos)

	if !positionToCell.has(left_pos):
		_create_covered_cell_on_pos(left_pos)

	if !positionToCell.has(right_pos):
		_create_covered_cell_on_pos(right_pos)
