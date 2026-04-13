extends Node2D

var resource = load("uid://d1hcqjdkdqx5t") # change this to the current soul's dialogue
var ball_resource = load("uid://dvsqxeowariv7")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Zoom") and $Player/Camera2D.enabled == false:
		print("zoomz")
		$Player/Camera2D.enabled = true
		$Camera2D.enabled = false
	elif event.is_action_pressed("Zoom") and $Player/Camera2D.enabled == true:
		$Camera2D.enabled = true
		$Player/Camera2D.enabled = false
		
var UIDString


func _ready() -> void:
	var UID = ResourceLoader.get_resource_uid(get_tree().current_scene.scene_file_path)
	UIDString = ResourceUID.id_to_text(UID)
	$ColorRect.modulate.a = 1
	var tw = create_tween().set_ignore_time_scale().tween_property($ColorRect, "modulate:a", 0, 1).set_delay(2.0)
	
	await tw.finished
	
	set_process_input(true)
	
	await get_tree().create_timer(3.0).timeout
	
	cutscene_watch()
	
	await DialogueManager.dialogue_ended
	
	set_process_input(true)
	
	await get_tree().create_timer(5.0).timeout
	#mem_finished()

func cutscene_watch():
	set_process_input(false)
	$Camera2D.enabled = true
	$Player/Camera2D.enabled = false
	DialogueManager.show_dialogue_balloon_scene(ball_resource, resource, "start")
		
func mem_finished():
	get_tree().paused = false
	get_parent().get_parent().get_parent().playerCam.enabled = true
	queue_free()
