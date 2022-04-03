extends Node


func position_inside_cell(pos:Vector2)->Vector2:
	randomize()
	var options_x = range(pos.x - SignalBus.CELL_SIZE / 2 + SignalBus.SPRITE_SIZE, pos.x + SignalBus.CELL_SIZE / 2 - SignalBus.SPRITE_SIZE, SignalBus.SPRITE_SIZE)
	var options_y = range(pos.y - SignalBus.CELL_SIZE / 2 + 2*SignalBus.SPRITE_SIZE, pos.y + SignalBus.CELL_SIZE / 2 - SignalBus.SPRITE_SIZE, SignalBus.SPRITE_SIZE)
	var rand_index:int = randi() % options_x.size()
	randomize()	
	var rand_index2:int = randi() % options_y.size()
	return Vector2(options_x[rand_index],options_y[rand_index2])
