extends Node2D

var balloon = load("uid://b4vdtsl8wg12c")
var dialogue = load("uid://ure4x7qk3vah")

@onready var white = $ColorRect

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	
	var tw = create_tween().tween_property(white, "modulate:a", 0, 2).set_ease(Tween.EASE_IN_OUT)
	await tw.finished
	
	DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Death")
	
	
	await DialogueManager.dialogue_ended
	
	SceneLoader.load_scene("uid://ctn0lntaoowe7", 2)
