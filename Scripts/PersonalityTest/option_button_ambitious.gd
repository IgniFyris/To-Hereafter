extends TextureButton

var q_num
var root_node

func _ready() -> void:
	root_node = self.get_parent().get_parent()
	pass

func _on_pressed() -> void:
	root_node.q_num += 1
	root_node.amb_num += 1
	for i in self.get_parent().get_children():
		if i is TextureButton:
			i.queue_free()
		else:
			pass
