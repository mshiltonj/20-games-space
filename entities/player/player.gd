class_name Player
extends CharacterBody2D

@export var speed: int = 300
const BULLET : PackedScene = preload("res://entities/bullet/Bullet.tscn")
const EXPLOSION : PackedScene = preload("res://entities/explosion/Explosion.tscn")

@onready var bullet_timer : Timer = $BulletTimer
@onready var bullet_cooldown : bool = false

func _ready() -> void:
	AudioManager.register("bullet_fire", load("res://entities/player/laserShoot.wav"))
	bullet_timer.timeout.connect(func() -> void: bullet_cooldown = false )

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_fire"):
		fire_bullet()

func _process(delta : float) -> void:
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed * delta
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed * delta
	else:
		velocity.x = 0
		
	var collision : KinematicCollision2D = move_and_collide(velocity)
	if collision:
		if collision.get_collider().is_in_group("aliens"):
			self.destroy()
	
func fire_bullet() -> void:
	if bullet_cooldown:
		return
		
	var bullet : Bullet = BULLET.instantiate()
	bullet.position = Vector2(self.global_position)
	AudioManager.play("bullet_fire")
	bullet_cooldown = true
	bullet_timer.start()
	get_parent().add_bullet(bullet)
	
func destroy() -> void:
	var splode : Node2D = EXPLOSION.instantiate()
	queue_free()
	splode.global_position = Vector2(self.global_position)
	get_parent().get_parent().add_child(splode)
	Signals.player_destroyed.emit()
	
