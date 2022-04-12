extends Node2D

onready var cell = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_Torch_tree_entered() -> void:
	cell.is_lighted = true
