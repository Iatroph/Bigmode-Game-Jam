extends CharacterBody2D

var gravity = ProjectSettings.get_setting(("physics/2d/default_gravity"))
@export var ground_speed = 125
@export var air_speed = 75
@export var acceleration = 300
var bounce_accel = 150
@export var jump_strength = -250
var move_direction

var bounces = 0
var bounce_strength = 500
var bounce_multiplier = 1.2

var is_bouncing = false

var throw_direction : Vector2

@onready var sprite = $AnimatedSprite2D

@onready var throwing_chair = preload("res://Scenes/thrown_chair.tscn")

func _physics_process(delta):
	#Apply gravity when not grounded
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		bounces = 0
		#is_bouncing = false
	
	if Input.is_action_just_pressed("Jump") && is_on_floor():
		velocity.y = 0
		velocity.y = jump_strength
	
	velocity.y = clamp(velocity.y,-1000,600)
	#if !is_bouncing:
	move_direction = Input.get_axis("Left","Right")
	#move_direction = Vector2(Input.get_action_strength("Left"), Input.get_action_strength("Right"))
	#print(move_direction)
	#print(velocity)
	if move_direction && is_on_floor():
		velocity.x = move_direction * ground_speed
		#velocity.x = move_toward(velocity.x, move_direction * ground_speed, acceleration * delta)
	elif move_direction && not is_on_floor():
		#velocity.x = move_direction * air_speed
		#velocity.x = move_toward(velocity.x, move_direction * air_speed, acceleration * delta)
		if !is_bouncing:
			velocity.x = move_toward(velocity.x, move_direction * air_speed, acceleration * delta)
		else:
			velocity.x = move_toward(velocity.x, move_direction * air_speed, bounce_accel * delta)
	else:
		if is_on_floor():
			velocity.x = 0
		elif not is_on_floor():
			velocity.x = move_toward(velocity.x, 0, 0.2)
	move_and_slide()
	flip()
	

func _process(delta):
	throw_direction = get_global_mouse_position() - position
	print(throw_direction.normalized())
	#if Input.get_action_raw_strength("Mouse0"):
		#throw_chair()
	if Input.is_action_just_pressed("Mouse0"):
		throw_chair()

func throw_chair():
	var instance = throwing_chair.instantiate()
	instance.position = position
	#instance.position = get_global_mouse_position()
	#instance.apply_force(throw_direction * 250, Vector2.ZERO)
	instance.apply_central_force(throw_direction.normalized() * 30000)
	get_node("..").add_child(instance)
	

func flip():
	if move_direction > 0:
		sprite.flip_h = false
	elif move_direction < 0:
		sprite.flip_h = true

func apply_bounce(dir, pos):
	if !is_on_floor() && velocity.y > 0:
		#print(bounces)
		position = pos
		velocity = Vector2.ZERO
		#is_bouncing = true
		match bounces:
			0:
				velocity = dir * bounce_strength
			1:
				velocity = dir * bounce_strength * 1.2
			2:
				velocity = dir * bounce_strength * 1.4
			3:
				velocity = dir * bounce_strength * 1.6
			_:
				velocity = dir * bounce_strength
		bounces += 1
