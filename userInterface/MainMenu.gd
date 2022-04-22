extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://Main.tscn")


func _on_OptionButton_pressed() -> void:
	var options = load("res://userInterface/Options.tscn").instance()
	get_tree().current_scene.add_child(options)


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
