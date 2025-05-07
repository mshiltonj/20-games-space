class_name Alien
extends CharacterBody2D

@export var points: int = 10
@onready var sprite : Sprite2D = $Sprite2D 
@onready var fire_bullet_timer : Timer = $FireBulletTimer
@onready var fire_probability : float = 0.0010
const ALIEN_BULLET : PackedScene = preload("res://entities/alien-bullet/AlienBullet.tscn")
const EXPLOSION : PackedScene = preload("res://entities/explosion/Explosion.tscn")

func _ready() -> void:
	AudioManager.register("alien_destroy", load("res://entities/alien/powerUp.wav"))

func get_width() -> int:
	return(sprite.texture.get_width() * sprite.scale.x)
	
func _process(_delta: float) -> void:
	fire_bullet_check()

func fire_bullet_check() -> void:
	if randf() < fire_probability:
		var bullet : Node2D = ALIEN_BULLET.instantiate()
		bullet.position = Vector2(self.global_position)
		bullet.position.x += self.get_width() / 2
		self.get_parent().get_parent().add_child(bullet)
		
func destroy() -> void:
	var splode : Node2D = EXPLOSION.instantiate()
	Signals.alien_destroyed.emit(self.points)
	AudioManager.play("alien_destroy")
	queue_free()
	splode.global_position = Vector2(self.global_position)
	get_parent().get_parent().add_child(splode)
