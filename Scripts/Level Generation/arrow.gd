extends Control

var rotations = [0, 90, -180, -90]
var rot = randi_range(0, 3)

func _ready() -> void:
	self.rotation_degrees = rotations[rot]
	
