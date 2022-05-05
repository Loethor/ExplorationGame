extends Node2D


func _ready() -> void:
	z_index = 1
	
func init()->void:
	Player.gold_structures += 1
