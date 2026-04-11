extends CharacterBody2D

var arrowsContainer: PackedScene = preload("uid://hedujnigma4w")
@export var arrowConYPos : float

var arrowCon

func _ready() -> void:
	pass

func _on_killzone_body_entered(body: Node2D) -> void:
	if body is Player:
		arrowCon = arrowsContainer.instantiate()
		add_child(arrowCon)
		var arrowRots = arrowCon.arrowRots
		
		arrowCon.position.y = arrowConYPos

func _on_killzone_body_exited(body: Node2D) -> void:
	if body is Player:
		Engine.time_scale = 1
		if arrowCon:
			arrowCon.queue_free()
