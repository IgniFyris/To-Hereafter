extends CharacterBody2D

var arrowsContainer: PackedScene = preload("uid://hedujnigma4w")
@export var arrowConYPos : float

var arrowPicRes = load("uid://cokccv0240pwm")
var arrowPicResH = load("uid://drk7gt8ct3hpf")

var arrowCon
var arrowRots
var keys = []
var input = 1

var previousInput

var current_input_buffer = []

func _ready() -> void:
	set_process_input(false)
	
func _input(event: InputEvent) -> void:
	if input == 1:
		if event is InputEventKey and event.pressed:
			print(OS.get_keycode_string(event.keycode))
			if not event.echo:
				if OS.get_keycode_string(event.keycode) == keys[0]:
					print("first one right")
					arrowCon.arrow1Container.get_child(0).texture_normal = arrowPicResH
					input = 2
				else:
					print("apparently first input failed")
					arrowCon.arrow1Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow2Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow3Container.get_child(0).texture_normal = arrowPicRes
					
	elif  input == 2:
		if event is InputEventKey and event.pressed:
			if not event.echo:
				if OS.get_keycode_string(event.keycode) == keys[1]:
					print("second one right")
					arrowCon.arrow2Container.get_child(0).texture_normal = arrowPicResH
					input = 3
				else:
					print("apparently second input failed")
					arrowCon.arrow1Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow2Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow3Container.get_child(0).texture_normal = arrowPicRes
					input = 1

	elif  input == 3:
		if event is InputEventKey and event.pressed:
			if not event.echo:
				if OS.get_keycode_string(event.keycode) == keys[2]:
					print("third one right")
					arrowCon.arrow3Container.get_child(0).texture_normal = arrowPicResH
					kill_self()
				else:
					print("apparently third input failed")
					arrowCon.arrow1Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow2Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow3Container.get_child(0).texture_normal = arrowPicRes
					input = 1

func _on_killzone_body_entered(body: Node2D) -> void:
	if body is Player:
		arrowCon = arrowsContainer.instantiate()
		add_child(arrowCon)
		arrowRots = arrowCon.arrowRots
		
		arrowCon.position.y = arrowConYPos
		
		for i in arrowRots:
			if i == 0.0:
				keys.append("Right")
			elif i == 90.0:
				keys.append("Down")
			elif i == -180.0:
				keys.append("Left")
			elif i == -90.0:
				keys.append("Up")
				
		input = 1
		
		print(arrowRots)
		print(keys)
		set_process_input(true)

func _on_killzone_body_exited(body: Node2D) -> void:
	if body is Player:
		Engine.time_scale = 1
		if arrowCon:
			arrowCon.queue_free()
		print(arrowRots)
		print(keys)
		keys.clear()
		set_process_input(false)

func kill_self():
	self.queue_free()
