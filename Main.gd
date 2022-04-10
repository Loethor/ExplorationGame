extends Node2D

onready var roomManager = preload("res://scenes/RoomManager.tscn")
onready var rm : Node = roomManager.instance()

export var DEBUG = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(rm)
	if DEBUG:
		Player.gold += 9999


	
func _on_Timer_timeout() -> void:
	Player.gold += 15 * Player.gold_structures
