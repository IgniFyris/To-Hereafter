extends AudioStreamPlayer

@onready var ExpoDumpMusic = $ExpoDumpMusic
@onready var PersonalityTest = $PersonalityTest
@onready var soul_2: AudioStreamPlayer = $Soul2

func _on_finished() -> void:
	self.play()

func _on_expo_dump_music_finished() -> void:
	ExpoDumpMusic.play()

func _on_personality_test_finished() -> void:
	PersonalityTest.play()

func _on_soul_2_finished() -> void:
	soul_2.play()
