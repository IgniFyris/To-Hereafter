extends Sprite2D

@export var interactable: Area2D

func _ready() -> void:
	interactable.interact = _on_interact
	$"../Player/Info".hide()

func _on_interact():
	$"../Player/Info".show()
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
