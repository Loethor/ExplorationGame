extends Node2D


onready var cost_to_unlock:int
onready var cost_label : Label = $Label
onready var cell = $"../.."
var dist : int = 0



func _on_StaticBody2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if Player.gold >= cost_to_unlock:
				Player.gold -= cost_to_unlock
				
				$StaticBody2D/CollisionShape2D.disabled = true
				$Crack.visible = false 
				$Door.visible = true
			else:
				print("Need more gold.")


func _on_StaticBody2D_mouse_entered() -> void:
	cost_label.visible = true


func _on_StaticBody2D_mouse_exited() -> void:
	cost_label.visible = false
