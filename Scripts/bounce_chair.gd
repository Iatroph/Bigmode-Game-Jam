extends RigidBody2D

@export var dir : Node2D

func _on_area_2d_body_entered(body):
	if body.name == "Player" && !body.is_on_floor():
		if body.has_method("apply_bounce"):
			#body.apply_bounce(global_transform.basis_xform(Vector2.UP), position)
			#var test = Vector2(cos(rotation), sin(rotation))
			#print(dir.global_rotation_degrees)
			#print(dir.rotation_degrees)
			body.apply_bounce(dir.global_transform.basis_xform(Vector2.UP), dir.global_position)
			#print(rad_to_deg(dir.global_transform.basis_xform(Vector2.UP).angle()))
