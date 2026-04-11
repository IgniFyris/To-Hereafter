extends HBoxContainer

@onready var arrow1Container = $Control
@onready var arrow2Container = $Control2
@onready var arrow3Container = $Control3

var arrows: PackedScene = preload("uid://dbek0gflfiowy")
var arrow1
var arrow2
var arrow3
var arrowRots = []

func _ready() -> void:
	Engine.time_scale = 0.02
	create_arrows()

func delete_arrows():
	self.queue_free()

func create_arrows():
	arrow1 = arrows.instantiate()
	arrow2 = arrows.instantiate()
	arrow3 = arrows.instantiate()
	arrow1Container.add_child(arrow1)
	arrow2Container.add_child(arrow2)
	arrow3Container.add_child(arrow3)
	
	self.visible = true
	
	get_rots()
	
func get_rots():
	for i in self.get_children():
		if i is not AnimationPlayer:
			arrowRots.append(i.get_child(0).rotation_degrees)
