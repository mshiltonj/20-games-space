class_name AlienBullet
extends CharacterBody2D

@onready var speed : int = -200

func _ready() -> void:
	pass

func _process(delta : float) -> void:
	velocity.y = -speed * delta
	var collision : KinematicCollision2D = move_and_collide(velocity)
	if collision:
		var collider : Node2D = collision.get_collider()
		if collider.is_in_group("bullets"):
			self.queue_free()
			collider.queue_free()
		elif collider.is_in_group("shields"):
			collider.hit()
			self.queue_free()
		elif collider.is_in_group("player"):
			collider.destroy()
			self.queue_free()
	
	
