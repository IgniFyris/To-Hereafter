extends Node2D

var balloon = load("uid://b4vdtsl8wg12c")
var dialogue = load("uid://b05mgkw3ad0yw")

# Barriers
@onready var MemCol = $Barriers/MemoryCollect/CollisionShape2D

# Areas
@onready var Monster = $TutAreas/Monster

# Essentials
@onready var Mons = $BasicMonster
@onready var MemFrag = $Memfrag
@onready var SanityBar = $Player/CanvasLayer/SanityBarr

# Labels
@onready var LMem = $Labels/Memory
@onready var LBanish = $Labels/Banish

var tween

func _ready() -> void:
	SanityBar.visible = false
	Mons.set_physics_process(false)
	MemCol.disabled = false
	Mons.KillZone.monitoring = false
	MemFrag.monitoring = false
	MemFrag.modulate.a = 0
	await get_tree().create_timer(2.0).timeout
	
	DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "minimaze")
	
	await DialogueManager.dialogue_ended
	
	MemFrag.monitoring = true
	
	create_tween().tween_property(MemFrag, "modulate:a", 1, 1)
	create_tween().tween_property(LMem, "modulate:a", 1, 1)


func _on_memory_fragment_body_entered(body: Node2D) -> void:
	if body is Player:
		SanityBar.modulate.a = 0
		SanityBar.visible = true
		SanityBar.Dep.stop()
		SanityBar.value = 460
		create_tween().tween_property(MemFrag, "modulate:a", 0, 1)
		create_tween().tween_property(LMem, "modulate:a", 0, 1)
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "aftermem")
		await DialogueManager.dialogue_ended
		
		MemCol.disabled = true

func _on_monster_body_entered(body: Node2D) -> void:
	if body is Player:
		SanityBar.Dep.stop()
		SanityBar.value = 460
		create_tween().tween_property(SanityBar, "modulate:a", 1, 1)
		create_tween().tween_property(Mons, "modulate:a", 1, 1)
		MemCol.call_deferred("disabled", false)
		Monster.set_deferred("monitoring", false)
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "defend")
		
		await DialogueManager.dialogue_ended
		
		create_tween().set_ignore_time_scale().tween_property(LBanish, "modulate:a", 1, 1)
		Mons.KillZone.monitoring = true
		
		await Mons.tree_exited
		
		SanityBar.value = 500
		
		DialogueManager.show_dialogue_balloon_scene(balloon, dialogue, "sanity")
		
		await DialogueManager.dialogue_ended
		
		create_tween().set_ignore_time_scale().tween_property(SanityBar, "modulate:a", 0, 1)
		SceneLoader.load_scene("uid://djcku17220ge2", 1)
		
		
