extends Node2D

### Signals
signal SurroundRequired


### Game constants
var CELL_SIZE = 256
var SPRITE_SIZE = 32

### Spawns constants
var gold_chance = 20


var room_count:int = 0 setget set_room_count,get_room_count

func set_room_count(value:int)->void:
	room_count = value
	
func get_room_count()->int:
	return room_count

