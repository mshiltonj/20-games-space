extends Control


func _on_button_pressed() -> void:
	SceneManager.load_scene("Main", self)
