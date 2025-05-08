extends Control

@onready var play_again : Button = $CenterContainer/VBoxContainer/MarginContainer/VBoxContainer/PlayAgain
@onready var main_menu : Button = $CenterContainer/VBoxContainer/MarginContainer/VBoxContainer/MainMenu
@onready var final_score_value : Label = $MarginContainer/PanelContainer/CenterContainer/VBoxContainer/MarginContainer/VBoxContainer/CenterContainer2/FinalScoreValue

@export var game : Node2D

func _ready() -> void:
	pass

func set_score(score : int) -> void:
	final_score_value.text = "%d" % score

func _on_main_menu_pressed() -> void:
	SceneManager.load_scene("Main", game)

func _on_play_again_pressed() -> void:
	SceneManager.load_scene("Game", game)
