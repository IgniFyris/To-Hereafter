extends Node2D

@onready var ExpoDump1 = $ExpoDump1
@onready var ExpoDump2 = $ExpoDump2
@onready var ExpoDump3 = $ExpoDump3

var viewport

var resource = load("uid://d1hcqjdkdqx5t")

func _ready() -> void:
	viewport = get_viewport_rect().size
	
	MainMenuMusic.stop()
	
	await get_tree().create_timer(2.0).timeout
	
	ExpoDump1.beVisible()

func _on_expo_dump_1_pressed() -> void:
	DialogueManager.show_dialogue_balloon(resource, "start")
	await DialogueManager.dialogue_ended
	
	ExpoDump2.beVisible()

func _on_expo_dump_2_pressed() -> void:
	DialogueManager.show_dialogue_balloon(resource, "expodump2")
	await DialogueManager.dialogue_ended
	
	ExpoDump3.beVisible()

func _on_expo_dump_3_pressed() -> void:
	DialogueManager.show_dialogue_balloon(resource, "expodump3")
	await DialogueManager.dialogue_ended
	
	ExpoDump1.beInvisible()
	ExpoDump2.beInvisible()
	ExpoDump3.beInvisible()
	
	await ExpoDump1.beInvisible().finished
	
	await get_tree().create_timer(2.0).timeout
	
	
