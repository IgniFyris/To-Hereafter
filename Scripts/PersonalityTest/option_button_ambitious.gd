extends TextureButton

var q_num

func _ready() -> void:
	pass

func _on_pressed() -> void:
	self.get_parent().get_parent().q_num += 1
	self.get_parent().get_parent().instantiated = false
	for i in self.get_parent().get_children():
		if i is TextureButton:
			i.queue_free()
		else:
			pass
