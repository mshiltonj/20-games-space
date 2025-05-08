extends Control

@export var Game : Node2D
@onready var label : Label = $MarginContainer/CenterContainer/Label

func _ready() -> void:
	pass

func set_wave(current_wave: int) -> void:
	label.text = "Wave %d" % current_wave
