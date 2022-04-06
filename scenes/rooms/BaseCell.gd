extends Node2D

onready var goldGenerator = preload("res://scenes/GoldGenerator.tscn")
onready var array_of_structures:Array = []
onready var grid_position:Vector2
onready var distance_from_origin:int

onready var has_top_wall : bool = true
onready var has_left_wall : bool = true
onready var has_right_wall : bool = true
onready var has_bottom_wall : bool = true

var room_id : int setget set_room_id, get_room_id
var lb = Label.new()

func init(pos:Vector2, id:int) -> void:
	set_position(pos)
	room_id = id
	grid_position = Vector2(pos.x / SignalBus.CELL_SIZE, pos.y / SignalBus.CELL_SIZE)

	distance_from_origin = abs(grid_position.x)+abs(grid_position.y)
	
	
	add_child(lb)

func _process(delta: float) -> void:
	lb.text = "Room: %s" % room_id

	
func set_position(pos:Vector2) -> void:
	position = pos
	
func get_position() -> Vector2:
	return position

func _is_uncovered():
	SignalBus.emit_signal("SurroundRequired", self)
	if array_of_structures.size() > 0:
		activate_structures()

# TODO: add it to Generator manager		
func add_gold_generator():
	var gg:Object = goldGenerator.instance()
	gg.position = Utils.position_inside_cell(to_local(self.position))

	print("there is a chest in %s" % grid_position)
	
	add_child(gg)
	array_of_structures.append(gg)
	
func activate_structures():
	for structure in array_of_structures:
		structure.init()

func set_room_id(value:int)->void:
	room_id = value
	
func get_room_id()->int:
	return room_id
