extends Node2D

var balloon = load("uid://b4vdtsl8wg12c")
var dialogue = load("uid://ure4x7qk3vah")

var Death : PackedScene = preload("uid://clhndl6lyljpc")

# Memory Scenes
@onready var Ap_1: Sprite2D = $Mem1/P1
@onready var Ap_2: Sprite2D = $Mem1/P2
@onready var Ap_3: Sprite2D = $Mem1/P3

@onready var Bp_1: Sprite2D = $Mem2/P1
@onready var Bp_2: Sprite2D = $Mem2/P2

@onready var Cp_1: Sprite2D = $Mem3/P1
@onready var Cp_2: Sprite2D = $Mem3/P2
@onready var Cp_3: Sprite2D = $Mem3/P3

@onready var Dp_1: Sprite2D = $Mem4/P1


func _ready() -> void:
	if GlobalVars.memoryAmt == 1:
		Ap_1.visible = true
	elif GlobalVars.memoryAmt == 2:
		Bp_1.visible = true
	elif GlobalVars.memoryAmt == 3:
		Cp_1.visible = true
	elif GlobalVars.memoryAmt == 4:
		Dp_1.visible = true
	$ColorRect.modulate.a = 1
	var tw = create_tween().tween_property($ColorRect, "modulate:a", 0, 1)
	await tw.finished
	if GlobalVars.memoryAmt == 1:
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem1_A")
		await DialogueManager.dialogue_ended
		
		create_tween().tween_property(Ap_2, "modulate:a", 1, 1)
		
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem1_B")
		await DialogueManager.dialogue_ended
		
		create_tween().tween_property(Ap_3, "modulate:a", 1, 1)
		
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem1_C")
		await DialogueManager.dialogue_ended
		mem_finished()
		
	elif GlobalVars.memoryAmt == 2:
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem2_A")
		await DialogueManager.dialogue_ended
		
		create_tween().tween_property(Bp_2, "modulate:a", 1, 1)
		
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem2_B")
		await DialogueManager.dialogue_ended
		mem_finished()
		
	elif GlobalVars.memoryAmt == 3:
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem3_A")
		await DialogueManager.dialogue_ended
		
		create_tween().tween_property(Cp_2, "modulate:a", 1, 1)
		
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem3_B")
		await DialogueManager.dialogue_ended
		
		create_tween().tween_property(Cp_3, "modulate:a", 1, 1)
		
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem3_C")
		await DialogueManager.dialogue_ended
		mem_finished()
		
	elif GlobalVars.memoryAmt == 4:
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "Mem4_A")
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
