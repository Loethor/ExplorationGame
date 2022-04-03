extends Control


onready var gold: Label = get_node("GoldLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player.connect("GoldUpdated", self, "update_interface")
	update_interface()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func update_interface() -> void:
	gold.text = "Gold: %s" % Player.gold
