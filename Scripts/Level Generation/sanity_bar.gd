extends TextureProgressBar

func _on_depletion_timeout() -> void:
	self.value -= 1
