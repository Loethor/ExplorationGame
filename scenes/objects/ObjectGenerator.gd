class_name ObjectGenerator 

onready var goldMineScene : PackedScene 

func _ready() -> void:
	pass
	
func generate_gold_mine()->Object:
	goldMineScene = load("res://scenes/objects/goldvein/GoldVein.tscn")
	return goldMineScene.instance()
