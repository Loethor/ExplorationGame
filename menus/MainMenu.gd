extends Control

func _ready() -> void:
	$VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://scenes/main/Main.tscn")

func _on_OptionButton_pressed() -> void:
	var options = load("res://menus/Options.tscn").instance()
	get_tree().current_scene.add_child(options)

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
