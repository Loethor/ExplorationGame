extends Node2D

### Signals
signal DoorOpened(cell,type_of_door)
signal UpdateLabels
signal LimitsChanged


### Game constants
const CELL_SIZE = 256
const SPRITE_SIZE = 32

### Game variables
var current_zoom = Vector2(1,1)


### Spawns constants
var gold_chance = 20


var room_count:int = 0 setget set_room_count,get_room_count


func set_room_count(value:int)->void:
	room_count = value
	
func get_room_count()->int:
	return room_count

