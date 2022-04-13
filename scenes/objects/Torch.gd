extends Node2D

onready var cell = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		cell.is_lighted = true
