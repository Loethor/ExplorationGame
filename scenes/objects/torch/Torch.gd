
class_name TorchItem extends Node2D

#var path = "res://scenes/objects/torch/Torch.tscn"

func _ready() -> void:
		_light()

func _light():
	$Light2D.visible = true
