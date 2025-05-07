extends AnimatedSprite2D


func _ready() -> void:
	self.animation_looped.connect(func() -> void: 
		self.queue_free()
	)
	self.play("default")
