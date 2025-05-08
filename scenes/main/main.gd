extends Control

func _ready() -> void:
	pass

func _on_play_button_pressed() -> void:
	SceneManager.load_scene("Game", self)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	SceneManager.load_scene("Credits", self)


func _on_how_to_pressed() -> void:
	SceneManager.load_scene("HowTo", self)
