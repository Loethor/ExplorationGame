extends Node2D

func init(pos:Vector2) -> void:
	_setPosition(pos)
	
func _setPosition(pos:Vector2) -> void:
	position = pos

func _is_uncovered():
	SignalBus.emit_signal("SurroundRequired", self)
