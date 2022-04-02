extends Node2D


var CELL_SIZE = 96

#onready var cell = preload("res://scenes/Cell.tscn")
#onready var cover = preload("res://scenes/Cover.tscn")
#onready var emptyCell = preload("res://scenes/EmptyCell.tscn")

export var emptyCell : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var main_cell:Object = _create_cell(0,0)
	
	add_child(main_cell)
#	_create_covered_cell(0, CELL_SIZE)

#	var cv = cover.instance()
#	var ccl = cell.instance()
#	ccl.add_child(cv)
	

#	ccl.position = Vector2(CELL_SIZE/2, 3*CELL_SIZE/2)
#	self.add_child(ccl)
	
	
func _create_cell(x:int, y:int)->Object:
	var ec = emptyCell.instance()
#	print(ec)
	ec.init(Vector2(x,y))
	return ec
	
#func _create_covered_cell(x:int, y:int):
#	var cl = _create_cell(x,y)
#	var cv = cover.instance()
#	cl.add_child(cv)
#	return cl
