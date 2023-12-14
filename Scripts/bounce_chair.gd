extends RigidBody2D

@export var dir : Node2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var death_particle = preload("res://Scenes/Particles/chair_explode_particle.tscn")

func destroy_self():
	var instance = death_particle.instantiate()
	instance.position = position
	get_node("..").add_child(instance)
	queue_free()


func _on_area_2d_body_entered(body):
	if body.name == "Player" && !body.is_on_floor():
		if body.has_method("apply_bounce"):
			sprite.play("boing")
			#body.apply_bounce(global_transform.basis_xform(Vector2.UP), posia
			#print(dir.global_rotation_degrees)
			#print(dir.rotation_degrees)
			body.apply_bounce(dir.global_transform.basis_xform(Vector2.UP), dir.global_position)
			#print(rad_to_deg(dir.global_transform.basis_xform(Vector2.UP).angle()))
