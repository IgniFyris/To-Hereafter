extends Node2D

@onready var CLLogo = $CL_Logo
@onready var CLText = $CL_Text
var width
var height

func _ready() -> void:
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	CLText.modulate.a = 0
	CLLogo.modulate.a = 1
	
	CLLogo.position = Vector2(width/2, height/2)

	var LogoFadeOut = create_tween().tween_property(CLLogo, "modulate:a", 0, 1).set_delay(2)
	await LogoFadeOut.finished
	
	var TextFadeIn = create_tween().tween_property(CLText, "modulate:a", 1, 1)
	await TextFadeIn.finished
	
	var TextFadeOut = create_tween().tween_property(CLText, "modulate:a", 0, 1).set_delay(2)
	await TextFadeOut.finished
	
	SceneLoader.load_scene("uid://cvp7sk28csjfr", 0)
