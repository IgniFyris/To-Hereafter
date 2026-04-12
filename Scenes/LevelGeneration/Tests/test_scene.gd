extends Node2D

var resource = load("uid://d1hcqjdkdqx5t")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Zoom") and $Player/Camera2D.enabled == false:
		print("zoomz")
		$Player/Camera2D.enabled = true
		$Camera2D.enabled = false
	elif event.is_action_pressed("Zoom") and $Player/Camera2D.enabled == true:
		$Camera2D.enabled = true
		$Player/Camera2D.enabled = false
		

func _ready() -> void:
	set_process_input(true)
	
	await get_tree().create_timer(3.0).timeout
	
	cutscene_watch()

func cutscene_watch():
	set_process_input(false)
	$Camera2D.enabled = true
	$Player/Camera2D.enabled = false
	DialogueManager.show_dialogue_balloon(resource, "start")
