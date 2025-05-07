extends Node2D
@onready var bullet_collector : Area2D = $BulletCollector
@onready var alien_direction : int = -1
@onready var movement_timer : Timer = $MovementTimer
@onready var take_step : bool = false
@onready var aliens : Node2D = $Aliens
@onready var ship_timer : Timer = $ShipTimer
@onready var ship_group : Node2D = $ShipGroup
@onready var ship : Node2D = $ShipGroup/Ship
@onready var score_label : Label = $Score
@onready var lives : int = 2
@onready var lives_group : Node2D = $LivesGroup

@onready var game_over_overlay : Control = $Overlays/GameOver


# MOVEMENT TIMER 0.7

const RIGHT_BORDER : int = 650
const LEFT_BORDER : int =  158

const PLAYER_SPRITE_ONLY : PackedScene = preload("res://entities/player/PlayerSpriteOnly.tscn")
const PLAYER : PackedScene = preload("res://entities/player/Player.tscn")
@onready var player : Node2D = $Player

const ALIEN_1 : PackedScene = preload("res://entities/alien/Alien1.tscn")
const ALIEN_2 : PackedScene = preload("res://entities/alien/Alien2.tscn")
const ALIEN_3 : PackedScene = preload("res://entities/alien/Alien3.tscn")

@onready var score : int = 0
@onready var new_life_timer : Timer = Timer.new()

func _ready() -> void:
	AudioManager.register("alien_step", load("res://scenes/game/blipSelect.wav"))
	GlobalState.current_level = self
	bullet_collector.body_entered.connect(func(body : CharacterBody2D) -> void: 
		body.queue_free() 
	)
	movement_timer.timeout.connect(alien_step)
	ship_timer.timeout.connect(ship_launch)
	Signals.connect("alien_destroyed", on_alien_destroyed)
	Signals.player_destroyed.connect(on_player_destroyed)
	init_alien_formation()
	show_lives_left()
	
	new_life_timer.wait_time = 0.75
	new_life_timer.one_shot = true
	new_life_timer.timeout.connect(func() -> void : 
		var life_icon : Node2D = lives_group.get_children().pop_back()
		if life_icon == null:
			game_over()
		else:
			lives_group.remove_child(life_icon)
			life_icon.queue_free()
			insert_player()
	)
	add_child(new_life_timer)

func game_over() -> void:
	game_over_overlay.set_score(score)
	game_over_overlay.visible = true;

func show_lives_left() -> void:
	var x_pos : int = 175
	var y_pos : int = 575
	for i : int in range(0, lives):
		var life : Node2D = PLAYER_SPRITE_ONLY.instantiate()
		lives_group.add_child(life)
		life.global_position = Vector2(x_pos + (i * 25), y_pos)
		
func insert_player() -> void:
	player = PLAYER.instantiate()
	player.global_position = Vector2(336, 528)
	add_child(player)

func init_alien_formation() -> void:
	var y_pos : int = 128
	var start_x_pos : int = 208
	var x_pos : int = start_x_pos #128
	for i :int in range(0,10):
		var alien : Node2D = ALIEN_3.instantiate()
		alien.position = Vector2(x_pos, y_pos)
		aliens.add_child(alien)
		x_pos += 40

	y_pos += 40
	x_pos = start_x_pos
	
	for i :int in range(0,10):
		var alien : Node2D = ALIEN_2.instantiate()
		alien.position = Vector2(x_pos, y_pos)
		aliens.add_child(alien)
		x_pos += 40

	y_pos += 40
	x_pos = start_x_pos

	for i :int in range(0,10):
		var alien : Node2D = ALIEN_2.instantiate()
		alien.position = Vector2(x_pos, y_pos)
		aliens.add_child(alien)
		x_pos += 40
		
	y_pos += 40
	x_pos = start_x_pos

	for i :int in range(0,10):
		var alien : Node2D = ALIEN_1.instantiate()
		alien.position = Vector2(x_pos, y_pos)
		aliens.add_child(alien)
		x_pos += 40
		
	y_pos += 40
	x_pos = start_x_pos

	for i :int in range(0,10):
		var alien : Node2D = ALIEN_1.instantiate()
		alien.position = Vector2(x_pos, y_pos)
		aliens.add_child(alien)
		x_pos += 40
		
func on_alien_destroyed(points: int) -> void:
	score += points
	score_label.text = "Score: %d" % score
	movement_timer.wait_time -= 0.013

func on_player_destroyed() -> void:
	new_life_timer.start()

func _process(_delta : float) -> void:
	if take_step: 
		aliens_take_step()
		take_step = false

func add_bullet(bullet : Bullet) -> void:

	add_child(bullet)
	
func alien_step() -> void:
	take_step = true
	
func aliens_take_step() -> void: 
	if aliens.get_children().size() == 0:
		return

	var aliens : Array = aliens.get_children()
	var direction_changed : bool = false
		
	if alien_direction == 1:
		for alien : Node2D in aliens:
			if alien.global_position.x + (alien.get_width() / 2) + 10 > RIGHT_BORDER:
				alien_direction = -1
				direction_changed = true
				break
				
	elif alien_direction == -1:
		for alien : Node2D in aliens:
			if alien.global_position.x - (alien.get_width() / 2) - 10 < LEFT_BORDER:
				alien_direction = 1
				direction_changed = true
				break
	
	for alien : Alien in aliens:
		if direction_changed:
			alien.position.y += 10
		else: 
			alien.position.x += 10 * alien_direction
	
	AudioManager.play("alien_step")
	
func ship_launch() -> void:
	ship.position = Vector2(-200, 80)
