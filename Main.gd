extends Node2D


var CELL_SIZE = 96

#onready var cell = preload("res://scenes/Cell.tscn")
#onready var cover = preload("res://scenes/Cover.tscn")

onready var baseCell = preload("res://scenes/BaseCell.tscn")
onready var hiddenLayer = preload("res://scenes/HiddenLayer.tscn")
#export var baseCell : PackedScene


var positionToCell : Dictionary = {}
var origin : Vector2 = Vector2.ZERO

var UnsurroundedCells : Array
var SurroundedCells : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("SurroundRequired", self, "_surround_cells")
	positionToCell[origin] = _create_cell(origin)
	UnsurroundedCells.append(positionToCell[origin])
	_surround_cells(positionToCell[origin])


	
	
func _create_cell(pos:Vector2)->Object:
	var ec = baseCell.instance()
	ec.init(pos)
	add_child(ec)
	return ec
	

	
func _create_covered_cell_on_pos(pos:Vector2)->void:
	var new_cell:Object = _create_covered_cell(pos)
	positionToCell[pos] = new_cell

	
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

			
func does_cell_exist(pos:Vector2)->bool:
	return pos in positionToCell
	
func _create_covered_cell(pos:Vector2):
	var cl = _create_cell(pos)
	var cv = hiddenLayer.instance()
	cl.add_child(cv)
	return cl



#func _create_cell_on_left(cell:Object):
#	var pos:Vector2 = cell.position
#	var new_pos:Vector2 = Vector2(pos.x-128,pos.y)
#	var new_cell:Object = _create_covered_cell(new_pos)
#	positionToCell[new_pos] = new_cell
#
#func _create_cell_on_right(cell:Object):
#	var pos:Vector2 = cell.position
#	var new_pos:Vector2 = Vector2(pos.x+128,pos.y)
#	var new_cell:Object = _create_covered_cell(new_pos)
#	positionToCell[new_pos] = new_cell
#
#func _create_cell_on_top(cell:Object):
#	var pos:Vector2 = cell.position
#	var new_pos:Vector2 = Vector2(pos.x,pos.y-128)
#	var new_cell:Object = _create_covered_cell(new_pos)
#	positionToCell[new_pos] = new_cell
#
#func _create_cell_on_bottom(cell:Object):
#	var pos:Vector2 = cell.position
#	var new_pos:Vector2 = Vector2(pos.x,pos.y+128)
#	var new_cell:Object = _create_covered_cell(new_pos)
#	positionToCell[new_pos] = new_cell
