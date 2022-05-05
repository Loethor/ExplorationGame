class_name BaseCell extends Node2D

onready var goldGenerator = preload("res://scenes/GoldGenerator.tscn")
onready var array_of_structures:Array = []
onready var grid_position:Vector2
onready var distance_from_origin:int


onready var has_top_wall : bool = true
onready var has_left_wall : bool = true
onready var has_right_wall : bool = true
onready var has_bottom_wall : bool = true

export var is_lighted := false

var room_id : int setget set_room_id, get_room_id
var lb = Label.new()

func _ready() -> void:
	lb.set_position(Vector2(SignalBus.CELL_SIZE/2,SignalBus.CELL_SIZE/2))
	add_child(lb)
	
func light_on():
	is_lighted = true
	
func light_off():
	is_lighted = false

func init(id:int) -> void:
	room_id = id
	grid_position = Vector2(position.x / SignalBus.CELL_SIZE, position.y / SignalBus.CELL_SIZE)

	distance_from_origin = Utils.distance_from_origin(grid_position)


func _do_nothing():
	pass # :D	
	
func _open_top():
	if has_node("Cracks/CrackDoorT"):
		$Cracks/CrackDoorT._open()
		
func _open_bottom():
	if has_node("Cracks/CrackDoorB"):
		$Cracks/CrackDoorB._open()

func _open_left():
	if has_node("Cracks/CrackDoorL"):
		$Cracks/CrackDoorL._open()

func _open_right():
	if has_node("Cracks/CrackDoorR"):
		$Cracks/CrackDoorR._open()

func _process(delta: float) -> void:
	lb.text = "Room: %s" % room_id

func add_structure_to_cell(structure: Object)->void:
	#TODO add a way of not repeting positions
	structure.position = Utils.random_position_inside_cell(to_local(self.position))
	add_child(structure)
	array_of_structures.append(structure)
	
func activate_structures():
	for structure in array_of_structures:
		structure.init()

func set_room_id(value:int)->void:
	room_id = value
	
func get_room_id()->int:
	return room_id
