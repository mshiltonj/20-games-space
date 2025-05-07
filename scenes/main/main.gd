extends Control

func _ready() -> void:
	print("main ready")

func _on_play_button_pressed() -> void:
	SceneManager.load_scene("Game", self)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	SceneManager.load_scene("Credits", self)
