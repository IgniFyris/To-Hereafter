extends Control

var optionsButtonsAmb : PackedScene = preload("uid://etxrw1xsmd7f")
var optionsButtonsCourage: PackedScene = preload("uid://etxrw1xsmd7f")
var optionsButtonsComp: PackedScene = preload("uid://etxrw1xsmd7f")
var resource = load("uid://e4mi38vfwerr")
@onready var Terminus = $Terminus
@onready var OptionsContainer = $OptionsContainer

func _ready() -> void:
	pass
	#Terminus.visible = true
	#await get_tree().create_timer(1.0).timeout
	#
	#DialogueManager.show_dialogue_balloon(resource, "start")
	#
	#await DialogueManager.dialogue_ended
	#
	#Terminus.visible = false
	
	var optionsAmb = optionsButtonsAmb.instantiate()
	var optionsCourage = optionsButtonsCourage.instantiate()
	var optionsComp = optionsButtonsComp.instantiate()
	OptionsContainer.add_child(optionsAmb)
	OptionsContainer.add_child(optionsComp)
	OptionsContainer.add_child(optionsCourage)
