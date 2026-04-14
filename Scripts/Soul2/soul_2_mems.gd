extends Node2D

var balloon = load("uid://b4vdtsl8wg12c")
var dialogue = load("uid://ure4x7qk3vah")

var Death : PackedScene = preload("uid://clhndl6lyljpc")

func _ready() -> void:
	$ColorRect.modulate.a = 1
	var tw = create_tween().tween_property($ColorRect, "modulate:a", 0, 1)
	await tw.finished
	if GlobalVars.memoryAmt == 1:
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem1")
		await DialogueManager.dialogue_ended
		mem_finished()
	elif GlobalVars.memoryAmt == 2:
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem2")
		await DialogueManager.dialogue_ended
		mem_finished()
	elif GlobalVars.memoryAmt == 3:
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem3")
		await DialogueManager.dialogue_ended
		mem_finished()
	elif GlobalVars.memoryAmt == 4:
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem4")
		await DialogueManager.dialogue_ended
		mem_finished()

func mem_finished():
	if GlobalVars.memoryAmt != 4:
		var tw = create_tween().tween_property($ColorRect, "modulate:a", 1, 0.5).set_ease(Tween.EASE_IN_OUT)
		await tw.finished
		get_parent().get_parent().get_parent().SanityBar.visible = true
		get_tree().paused = false
		get_parent().get_parent().get_parent().playerCam.enabled = true
		queue_free()
	else:
		var tw = create_tween().tween_property($ColorRect, "modulate:a", 1, 1).set_ease(Tween.EASE_IN_OUT)
		await tw.finished
		
		get_tree().paused = false
		get_tree().change_scene_to_packed(Death)
