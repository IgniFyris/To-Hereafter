extends TextureProgressBar

@onready var Dep = $Depletion

func _ready() -> void:
	var tw = create_tween().set_ignore_time_scale().tween_property(self, "modulate:a", 1, 2).set_delay(3.0)
	
	await tw.finished
	
	Dep.start()

func _on_depletion_timeout() -> void:
	self.value -= 1
