extends Node2D

onready var roomManager = preload("res://scenes/RoomManager.tscn")
onready var rm : Node = roomManager.instance()

export var DEBUG = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(rm)
	if DEBUG:
		Player.gold += 9999

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var mouse_position = get_global_mouse_position()
		print("Mouse Click at global: ", event.position)
		print("Mouse Click at global: ", mouse_position)
		print("Mouse Click at global snapped: ", mouse_position.snapped(Vector2(32,32)))

func _on_Timer_timeout() -> void:
	Player.gold += 15 * Player.gold_structures
