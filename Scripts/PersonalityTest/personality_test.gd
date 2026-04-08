extends Node2D

var resource = load("uid://e4mi38vfwerr")
@onready var Terminus = $Terminus

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	
	DialogueManager.show_dialogue_balloon(resource, "start")
	
	await DialogueManager.dialogue_ended
	
	Terminus.visible = false
