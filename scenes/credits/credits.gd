extends Control
@onready var credits_text_label : Label = $MarginContainer/VBoxContainer/ScrollContainer/CreditsText

func _ready() -> void:
	load_credits_text()

func _on_main_menu_pressed() -> void:
	SceneManager.load_scene("Main", self)

func load_credits_text() -> void:
	var file : FileAccess = FileAccess.open("res://scenes/credits/credits.txt", FileAccess.READ)
	var content : String = file.get_as_text()
	credits_text_label.text = content
