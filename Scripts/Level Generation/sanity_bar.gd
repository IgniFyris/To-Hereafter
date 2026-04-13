extends TextureProgressBar

func _ready() -> void:
	var tw = create_tween().set_ignore_time_scale().tween_property(self, "modulate:a", 1, 2).set_delay(1)
	
	await tw.finished
	
	$Depletion.start()

func _on_depletion_timeout() -> void:
	self.value -= 1
