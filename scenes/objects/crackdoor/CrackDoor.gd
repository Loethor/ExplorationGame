extends Node2D


onready var cost_to_unlock:int
onready var cost_label : Label = $Label
onready var cell = $"../.."
onready var roomManager = $"../../.."

var dist : int = 0
export var type_of_door:String

func _ready() -> void:
	SignalBus.connect("UpdateLabels", self, "_on_update_labels")
	

func _on_StaticBody2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if Player.gold >= roomManager.cost_to_unlock:
				Player.gold -= roomManager.cost_to_unlock
				_open()
				SignalBus.emit_signal("DoorOpened", cell, type_of_door)
			else:
				print("Need more gold.")
func _on_update_labels():
	cost_label.text = "Cost %s" % roomManager.cost_to_unlock

func _open():
	$StaticBody2D/CollisionShape2D.disabled = true
	$Crack.visible = false 
	$Door.visible = true


func _on_StaticBody2D_mouse_entered() -> void:
	cost_label.visible = true

func _on_StaticBody2D_mouse_exited() -> void:
	cost_label.visible = false
