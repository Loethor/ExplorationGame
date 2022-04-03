extends Node2D

onready var cell:Object = $".."
onready var cost_label : Label = $Label
onready var cost_to_unlock:int


func _ready() -> void:
	z_index = 2
	cost_to_unlock = cell.distance_from_origin * 5
#	cost_to_unlock.po
	cost_label.text = "Cost: %s" % cost_to_unlock

func _on_StaticBody2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if Player.gold >= cost_to_unlock:
				Player.gold -= cost_to_unlock
				cell._is_uncovered()
				queue_free()
			else:
				print("Need more gold.")

func _on_StaticBody2D_mouse_entered() -> void:
	cost_label.visible = true


func _on_StaticBody2D_mouse_exited() -> void:
	cost_label.visible = false
