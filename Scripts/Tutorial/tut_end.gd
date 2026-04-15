extends Node2D

var balloon = load("uid://b4vdtsl8wg12c")
var dialogue = load("uid://b05mgkw3ad0yw")

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "endoftut")
	await DialogueManager.dialogue_ended
	SceneLoader.load_scene("uid://byvjo0npg47ct", 3)
	create_tween().tween_property(Music.ExpoDumpMusic, "volume_db", -90.0, 3)
