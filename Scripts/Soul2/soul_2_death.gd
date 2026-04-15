extends Node2D

var balloon = load("uid://b4vdtsl8wg12c")
var dialogue = load("uid://ure4x7qk3vah")

@onready var death: Sprite2D = $Death

@onready var white = $ColorRect

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	
	var tw = create_tween().tween_property(white, "modulate:a", 0, 2).set_ease(Tween.EASE_IN_OUT)
	await tw.finished
	
	DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Death")
	
	await DialogueManager.dialogue_ended
	
	create_tween().tween_property(death, "modulate:a", 1, 1).set_ease(Tween.EASE_IN_OUT)
	
	DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Death2")
	
	await DialogueManager.dialogue_ended
	
	create_tween().tween_property(Music.soul_2, "volume_db", -90.0, 1.5)
	SceneLoader.load_scene("uid://ctn0lntaoowe7", 2)
	
