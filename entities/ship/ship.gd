extends CharacterBody2D

@onready var speed : int = 175
@onready var points : int = 100
const EXPLOSION : PackedScene = preload("res://entities/explosion/Explosion.tscn")

func _process(delta : float) -> void:
	velocity.x = speed * delta
	move_and_collide(velocity)

func destroy() -> void:
	var splode : Node2D = EXPLOSION.instantiate()
	Signals.alien_destroyed.emit(self.points)
	AudioManager.play("alien_destroy")
	splode.global_position = Vector2(self.global_position)
	get_parent().get_parent().add_child(splode)
	self.position.x = 810
