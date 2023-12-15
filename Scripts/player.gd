extends CharacterBody2D

var gravity = ProjectSettings.get_setting(("physics/2d/default_gravity"))
@export var ground_speed = 125
@export var air_speed = 75
@export var acceleration = 300
var bounce_accel = 100
@export var jump_strength = -250
var move_direction

var  can_move : bool = true

var bounces = 0
var bounce_strength = 500
var bounce_strength_cur = 500
var bounce_multiplier = 1.15

var is_bouncing = false

var throw_direction : Vector2

var face_dir : bool = false

@onready var sprite = $AnimatedSprite2D
@onready var chair_dir_sprite = $Sprite2D

@onready var throwing_chair = preload("res://Scenes/projectile_chair.tscn")
@onready var chair_projectile = preload("res://Scenes/projectile_chair.tscn")

var throw_strength = 100
var throw_ramp = 5
var max_throw_strength = 500

signal charge_meter_update

var is_charging : bool = false
var can_charge : bool = true

var can_throw : bool = true

var max_chairs = 4
var cur_chairs = 0
var chairs_held = 4

func _physics_process(delta):
	#Apply gravity when not grounded
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		bounces = 0
		is_bouncing = false
		bounce_strength_cur = bounce_strength
	
	if Input.is_action_just_pressed("Jump") && is_on_floor():
		velocity.y = 0
		velocity.y = jump_strength
	
	velocity.y = clamp(velocity.y,-2000,400)
	#if !is_bouncing:
	if can_move:
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
			velocity.x = move_toward(velocity.x, move_direction * bounce_strength_cur, bounce_accel * delta)
	else:
		if is_on_floor():
			velocity.x = 0
		elif not is_on_floor():
			velocity.x = move_toward(velocity.x, 0, 0.2)
	move_and_slide()
	flip()
	

func _process(delta):
	#throw_direction = get_global_mouse_position() - position
	throw_direction = global_position.direction_to(get_global_mouse_position())
	#print(throw_direction.normalized())
	#print(throw_strength)
	
	if cur_chairs < max_chairs:
		can_throw = true
	else:
		can_throw  = false
	
	if Input.is_action_just_pressed("R"):
		cur_chairs = 0
		chairs_held = 4
		Global.destroy_all_chairs()
	
	if Input.is_action_just_pressed("F"):
		face_dir = !face_dir
		chair_dir_sprite.flip_h = face_dir
		#print(face_dir)
	
	if Input.is_action_just_pressed("Mouse0"):
		pass
	
	if Input.is_action_pressed("Mouse0") && can_charge && can_throw:
		is_charging = true
		if is_charging:
			if throw_strength < max_throw_strength:
				throw_strength += throw_ramp
		
		if Input.is_action_just_pressed("Mouse1"):
			throw_strength = 100
			can_charge = false
			is_charging = false
	
	if Input.is_action_just_released("Mouse0") && can_throw:
		if is_charging:
			throw_chair()
		throw_strength = 100
		can_charge = true
	
	animation_handler()

func animation_handler():
	if !move_direction && is_on_floor():
		sprite.animation = "idle"
	
	if move_direction && is_on_floor():
		sprite.animation = "walk"
	
	if !is_on_floor():
		sprite.animation = "jump"

func throw_chair():
	cur_chairs += 1
	chairs_held -= 1
	var instance = throwing_chair.instantiate()
	instance.position = position
	#instance.position = get_global_mouse_position()
	#instance.apply_force(throw_direction * 250, Vector2.ZERO)
	#instance.apply_central_force(throw_direction.normalized() * 40000)
	#print(throw_direction)
	#instance.throw_velocity(throw_direction, 500, face_dir)
	get_node("..").add_child(instance)
	instance.throw_velocity(throw_direction, throw_strength, face_dir)
	

func flip():
	if move_direction > 0:
		sprite.flip_h = false
	elif move_direction < 0:
		sprite.flip_h = true

func apply_bounce(dir, pos):
	if !is_on_floor(): #|| is_bouncing: #&& velocity.y > 0:
		#print(bounces)
		velocity = Vector2.ZERO
		position = pos
		is_bouncing = true
		
		match bounces:
			0:
				bounce_strength_cur = bounce_strength_cur
				velocity = dir * bounce_strength_cur
			1:
				bounce_strength_cur = bounce_strength_cur * bounce_multiplier
				velocity = dir * bounce_strength_cur
			2:
				bounce_strength_cur = bounce_strength_cur * bounce_multiplier
				velocity = dir * bounce_strength_cur
			3:
				bounce_strength_cur = bounce_strength_cur * bounce_multiplier
				velocity = dir * bounce_strength_cur
			_:
				bounces = 0
				bounce_strength_cur = bounce_strength
				velocity = dir * bounce_strength_cur
		bounces += 1
		#print(bounce_strength_cur)
