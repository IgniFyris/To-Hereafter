extends Control

var optionsButtonsAmb : PackedScene = preload("uid://etxrw1xsmd7f")
var optionsButtonsCourage: PackedScene = preload("uid://cnqomw0enool4")
var optionsButtonsComp: PackedScene = preload("uid://dnw2bv5aebpyx")
var resource = load("uid://e4mi38vfwerr")
var q_num = 1
var instantiated = false
@onready var Terminus = $Terminus
@onready var OptionsContainer = $OptionsContainer

func _ready() -> void:
	set_process(false)
	OptionsContainer.visible = false
	Terminus.visible = true
	await get_tree().create_timer(1.0).timeout
	
	DialogueManager.show_dialogue_balloon(resource, "start")
	
	await DialogueManager.dialogue_ended
	
	Terminus.visible = false
	
	await get_tree().create_timer(2.0).timeout
	
	OptionsContainer.visible = true
	set_process(true)
	
func _process(_delta: float) -> void:
	if q_num != 6:
		if not OptionsContainer.get_child_count() == 4:
			personality_test()
	else:
		set_process(false)
		OptionsContainer.visible = false

func personality_test():
	var optionsAmb = optionsButtonsAmb.instantiate()
	var optionsCourage = optionsButtonsCourage.instantiate()
	var optionsComp = optionsButtonsComp.instantiate()
	optionsAmb.q_num = q_num
	optionsCourage.q_num = q_num
	optionsComp.q_num = q_num
	var q_buttons = [optionsAmb, optionsCourage, optionsComp]
	
	while not q_buttons.is_empty():
		var randomNum = randi_range(0,(q_buttons.size() - 1))
		var chosenButton = q_buttons[randomNum]
		OptionsContainer.add_child(chosenButton)
		q_buttons.remove_at(randomNum)
	
