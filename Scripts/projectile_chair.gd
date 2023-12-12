extends CharacterBody2D

var normal
var pos
var correct_rot
@onready var chair = preload("res://Scenes/bounce_chair.tscn")
@onready var chair_reverse = preload("res://Scenes/bounce_chair_reverse.tscn")
@onready var sprite = $Sprite2D
var chair_to_throw : PackedScene
var sprite_rot = 7
var rot_speed = 7

var gravity = ProjectSettings.get_setting(("physics/2d/default_gravity"))

func _ready():
	chair_to_throw = chair

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var collision = move_and_collide(velocity * delta)
	if collision:
		correct_rot = Vector2.UP.angle_to(collision.get_normal())
		var instance = chair_to_throw.instantiate()
		instance.global_position = collision.get_position()
		instance.global_rotation = correct_rot
		get_node("..").call_deferred("add_child", instance)
		Global.chairs.append(instance)
		queue_free()

func _process(delta):
	sprite.rotation_degrees += sprite_rot

func throw_velocity(direction, speed, chair_direction):

	if chair_direction == true:
		#print("LEFT")
		chair_to_throw = chair_reverse
	else:
		#print("RIGHT")
		chair_to_throw = chair
		
	velocity = direction * speed
	
	if direction.x > 0:
		sprite_rot = rot_speed
	else:
		sprite_rot = -rot_speed


