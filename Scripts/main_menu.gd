extends Control

func _on_begin_pressed() -> void:
	SceneLoader.load_scene("uid://bbxwnl4ctuot6", 1.5)

func _on_options_pressed() -> void:
	pass # Add Options Functionality

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_load_pressed() -> void:
	pass # Add Load Functionality

func _on_save_pressed() -> void:
	pass # Add Save Functionality
