extends Node2D

onready var cell:Object = $".."




func _on_StaticBody2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			cell._is_uncovered()
			queue_free()
