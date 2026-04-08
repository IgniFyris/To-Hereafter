extends Sprite2D

@export var interactable: Area2D

func _ready() -> void:
	interactable.interact = _on_interact
	
	
func _on_interact():
	interactable.is_interactable = false
	print("opened progresss menu")
	
