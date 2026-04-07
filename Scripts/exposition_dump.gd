extends Node2D

var resource = load("uid://d1hcqjdkdqx5t")

func _ready() -> void:
	MainMenuMusic.stop()
	var dialogue_line = DialogueManager.show_dialogue_balloon(resource, "start")
