extends Node

signal GoldUpdated



var gold: = 100 setget set_gold
var gold_structures := 0 setget set_gold_structures


func set_gold_structures(value: int) -> void:
	gold_structures = value

func set_gold(value: int) -> void:
	gold = value
	emit_signal("GoldUpdated")
