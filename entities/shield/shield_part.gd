extends StaticBody2D

@onready var health : int = 4
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.frame = 0
	AudioManager.register("shield_hit", load("res://entities/shield/shield_hit.wav"))


func hit() -> void:
	health -= 1
	animated_sprite.frame += 1
	AudioManager.play("shield_hit")
	if health <= 0:
		self.queue_free()
