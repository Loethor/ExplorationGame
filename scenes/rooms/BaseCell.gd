extends Node2D

onready var goldGenerator = preload("res://scenes/GoldGenerator.tscn")
onready var array_of_structures:Array = []
onready var grid_position:Vector2
onready var distance_from_origin:int

func init(pos:Vector2) -> void:
	set_position(pos)
	
	grid_position = Vector2(pos.x / 128, pos.y / 128)
#	print("My global position is %s and my grid position is %s" % [position, grid_position])
	distance_from_origin = abs(grid_position.x)+abs(grid_position.y)

	
func set_position(pos:Vector2) -> void:
	position = pos
	
func get_position() -> Vector2:
	return position

func _is_uncovered():
	SignalBus.emit_signal("SurroundRequired", self)
	if array_of_structures.size() > 0:
		activate_structures()

# TODO: add it to Room Manager		
func add_gold_generator():
	var gg:Object = goldGenerator.instance()
	gg.position = Utils.position_inside_cell(to_local(self.position))

	print("there is a chest in %s" % grid_position)
	
	add_child(gg)
	array_of_structures.append(gg)
	
func activate_structures():
	for structure in array_of_structures:
		structure.init()
