extends RigidBody2D

var normal
var pos
var correct_rot
@onready var chair = preload("res://Scenes/bounce_chair.tscn")
@onready var sprite = $Sprite2D

func _integrate_forces(state : PhysicsDirectBodyState2D) -> void:
	if(state.get_contact_count() > 0):
		#print(state.get_contact_local_normal(0))
		normal = state.get_contact_local_normal(0)
		pos = state.get_contact_local_position(0)
		#correct_rot = rad_to_deg(normal.angle())
		#correct_rot = rad_to_deg(Vector2.UP.angle_to(normal))
		correct_rot = Vector2.UP.angle_to(normal)
		

func _process(delta):
	sprite.rotation_degrees += 5

func _on_body_entered(body):
	if body.name == "TileMap":
		#freeze = true
		call_deferred("set_freeze_enabled", true)
		#print(normal)
		#print(pos)
		#print(correct_rot)
		var instance = chair.instantiate()
		instance.global_position = pos
		#instance.rotation = rot
		instance.global_rotation = correct_rot
		get_node("..").call_deferred("add_child", instance)
		#print("Make chair")
		queue_free()
		
	
