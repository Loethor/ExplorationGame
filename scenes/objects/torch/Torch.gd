extends Node2D

#onready var cell = $".."

var path = "res://scenes/objects/torch/Torch.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#		cell.is_lighted = true
		_light()

func _light():
	$Light2D.visible = true
