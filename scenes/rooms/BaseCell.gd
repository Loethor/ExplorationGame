extends Node2D

onready var goldGenerator = preload("res://scenes/GoldGenerator.tscn")
onready var roomManager = $".."
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
	pass
	

func init(id:int) -> void:
	room_id = id
	grid_position = Vector2(position.x / SignalBus.CELL_SIZE, position.y / SignalBus.CELL_SIZE)

	distance_from_origin = Utils.distance_from_origin(grid_position)
#	cost_to_unlock = distance_from_origin *5 +1
		
#	if has_node("Cracks"):
#		for crack in $Cracks.get_children():
#			crack.get_child(3).text = "Cost %s" % roomManager.cost_to_unlock
	add_child(lb)

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

func _is_uncovered():
	SignalBus.emit_signal("SurroundRequired", self)
	if array_of_structures.size() > 0:
		activate_structures()

# TODO: add it to Generator manager		
func add_gold_generator():
	var gg:Object = goldGenerator.instance()
	gg.position = Utils.random_position_inside_cell(to_local(self.position))

#	print("there is a chest in %s" % grid_position)
	
	add_child(gg)
	array_of_structures.append(gg)
	
func activate_structures():
	for structure in array_of_structures:
		structure.init()

func set_room_id(value:int)->void:
	room_id = value
	
func get_room_id()->int:
	return room_id

#TODO
func _on_StaticBody2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.doubleclick:
			$SelectedTileMap.visible = true
		if event.button_index == BUTTON_LEFT and event.pressed:
			var mouse_position = get_global_mouse_position()
			print($CaveTileMapUpdated.world_to_map(mouse_position))
