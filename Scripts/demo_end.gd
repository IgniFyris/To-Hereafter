extends Node2D

func _ready() -> void:
	Music.stop()
	
	await get_tree().create_timer(2.0).timeout
	
	Music.ExpoDumpMusic.play()
	create_tween().tween_property(Music.ExpoDumpMusic, "volume_db", 0, 1.5)
