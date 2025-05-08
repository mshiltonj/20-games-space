extends Control
@onready var credits_text_label : Label = $MarginContainer/VBoxContainer/ScrollContainer/CreditsText

func _ready() -> void:
	load_credits_text()

func _on_main_menu_pressed() -> void:
	SceneManager.load_scene("Main", self)

func load_credits_text() -> void:

	credits_text_label.text = """
Game developed in Godot
	https://godotengine.org/

Images created in Aseprite
	https://www.aseprite.org/

Sound Effects created in JSFXR
	https://sfxr.me/
	
Font used: Vipnagorgialla
https://www.1001fonts.com/vipnagorgialla-font.html
"""
