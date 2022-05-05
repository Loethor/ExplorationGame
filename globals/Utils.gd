extends Node


func random_position_inside_cell(pos:Vector2)->Vector2:
	var options_x = range(pos.x + SignalBus.SPRITE_SIZE, pos.x + SignalBus.CELL_SIZE  - SignalBus.SPRITE_SIZE, SignalBus.SPRITE_SIZE)
	var options_y = range(pos.y + 2*SignalBus.SPRITE_SIZE, pos.y + SignalBus.CELL_SIZE  - SignalBus.SPRITE_SIZE, SignalBus.SPRITE_SIZE)
	randomize()
	var rand_index:int = randi() % options_x.size()
	
	randomize()	
	var rand_index2:int = randi() % options_y.size()
	
	return Vector2(options_x[rand_index], options_y[rand_index2])

func random_from_array(array:Array):
	var rand_index:int = randi() % array.size()
	return array[rand_index]

func intersect(array1, array2):
	var intersection = []
	for item in array1:
		if array2.has(item):
			print("intersection found")
			print(item)
			intersection.append(item)
  return intersection


func intersect_arrays(arr1, arr2):
	var arr2_dict = {}
	for v in arr2:
		arr2_dict[v] = true

	var in_both_arrays = []
	for v in arr1:
		if arr2_dict.get(v, false):
			in_both_arrays.append(v)
	return in_both_arrays

func distance_from_origin(pos:Vector2):
	return abs(pos.x)+abs(pos.y)
	
	
func transport_globla_position_to_cell(position:Vector2):
	position += Vector2(128,128)

func step_vector_to(vector:Vector2, step)->Vector2:
	var rest_x :int 
	var rest_y :int 
	
	if vector.x >= 0:
		rest_x = vector.x / step
	else:
		rest_x = vector.x / step -1
	if vector.y >= 0:
		rest_y = vector.y / step
	else:
		rest_y = vector.y / step -1	
	return Vector2(rest_x*step, rest_y*step)
