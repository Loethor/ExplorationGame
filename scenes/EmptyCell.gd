extends Node2D

var CELL_SIZE = 96
var WALL_WIDHT = 16


#onready var hwall = preload("res://scenes/walls/HorizontalWall.tscn")
export var hwall : PackedScene
export var vwall : PackedScene
var size

func _ready() -> void:
#	print($Sprite.get_rect())
#	print($Sprite.get_rect().size)
#	self.size = $Sprite.get_rect().size
#	print(size)
	$Walls.add_child(_add_horizontal_wall())
#

func _add_horizontal_wall():
	return hwall.instance()

func init(pos:Vector2) -> void:
	print("hey")
	_setPosition(pos)
	_addTopWall()
	_addBottomWall()
	
func _setPosition(pos:Vector2) -> void:
	position = pos

func _addTopWall()->void:
	print('heyhey')
	var h = hwall.instance()
	h.position = (Vector2(0,0))
	$Walls.add_child(h)

func _addBottomWall()->void:
	var h = hwall.instance()
	h.position = (Vector2(self.size - WALL_WIDHT,0))
	$Walls.add_child(h)


#func _input(event):
#	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
#		if $Sprite.get_rect().has_point(to_local(event.position)):
#			print("A click!")
#			print(event.position)


