class_name Bullet
extends CharacterBody2D

@onready var speed : int = 350

func _ready() -> void:
	pass

func _process(delta : float) -> void:
	velocity.y = -speed * delta
	var collision : KinematicCollision2D = move_and_collide(velocity)
	if global_position.x < -100:
		self.queue_free()
	if collision:
		var collider : Node2D = collision.get_collider()
		if collider.is_in_group("aliens"):
			self.queue_free()
			collider.destroy()
		elif collider.is_in_group("shields"):
			collider.hit()
			self.queue_free()
			
	

	
