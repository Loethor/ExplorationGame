extends Node2D

onready var roomManager = preload("res://scenes/RoomManager.tscn")
onready var rm : Node = roomManager.instance()

onready var torch = preload("res://scenes/objects/Torch.tscn")


export var DEBUG = false
export var torch_sprite : Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(rm)
	if DEBUG:
		Player.gold += 9999


# this code places torches with "Q"
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("place_torch"):
		var mouse_position = get_global_mouse_position()
		var snapped_mouse = mouse_position.snapped(Vector2(256,256))
		if rm.positionToCell.has(snapped_mouse):
			var cell = rm.positionToCell[snapped_mouse]
			if !cell.is_lighted:
				var new_torch = torch.instance()
				new_torch.position = cell.to_local(mouse_position)
				cell.add_child(new_torch)
		

func _on_Timer_timeout() -> void:
	Player.gold += 15 * Player.gold_structures
