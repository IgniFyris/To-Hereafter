extends Node2D

var balloon = load("uid://b4vdtsl8wg12c")
var dialogue = load("uid://b05mgkw3ad0yw")

var tween

# Barriers
@onready var MoveJump = $Barriers/Movement_and_Jump/CollisionShape2D
@onready var BDash = $Barriers/Dash/CollisionShape2D

# Areas
@onready var TutEnd = $TutAreas/TutEnd
@onready var Jump = $TutAreas/Jump
@onready var ADash = $TutAreas/Dash
@onready var Form = $TutAreas/Form

# Labels
@onready var LMove = $Labels/Move
@onready var LJump = $Labels/Jump
@onready var LDash = $Labels/Dash
@onready var LForm = $Labels/Form

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	
	DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "start")
	
	tween = create_tween().tween_property(LMove, "modulate:a", 1, 1)
	GlobalVars.movement_jump = true
	MoveJump.disabled = false
	
	await DialogueManager.dialogue_ended
	
	MoveJump.disabled = true
	
func _on_form_body_entered(body: Node2D) -> void:
	if body is Player:
		LForm.modulate.a = 0
		tween = create_tween().tween_property(LForm, "modulate:a", 1, 1)
		Form.set_deferred("monitoring", false)
		BDash.set_deferred("disabled", false)
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "forms")
		
		await DialogueManager.dialogue_ended
		
		GlobalVars.form = true

func _on_dash_body_entered(body: Node2D) -> void:
	if body is Player:
		LJump.modulate.a = 0
		tween = create_tween().tween_property(LDash, "modulate:a", 1, 1)
		ADash.set_deferred("monitoring", false)
		MoveJump.set_deferred("disabled", false)
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "jumpdash")
		
		await DialogueManager.dialogue_ended
		
		GlobalVars.dash = true


func _on_jump_body_entered(body: Node2D) -> void:
	if body is Player:
		LMove.modulate.a = 0
		tween = create_tween().tween_property(LJump, "modulate:a", 1, 1)
		Jump.set_deferred("monitoring", true)


func _on_tut_end_body_entered(body: Node2D) -> void:
	if body is Player:
		TutEnd.set_deferred("monitoring", false)
		SceneLoader.load_scene("uid://bjhbxh7kbf02h", 1)
