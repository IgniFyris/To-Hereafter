extends Control

func show_only(target_name: String):
	for i in range(1, 6):
		get_node("HBoxContainer/Right/ScrollContainer/VBoxContainer/" + str(i) + " Info").hide()
	get_node("HBoxContainer/Right/ScrollContainer/VBoxContainer/" + target_name).show()

func _on_monster_1_pressed():
	show_only("1 Info")

func _on_monster_2_pressed():
	show_only("2 Info")

func _on_monster_3_pressed() -> void:
	show_only("3 Info")
	
func _on_monster_4_pressed() -> void:
	show_only("4 Info")

func _on_monster_5_pressed() -> void:
	show_only("5 Info")
