extends Area2D

#@onready var animation_player = $EndAnimation
@export var anim : AnimationPlayer

func _ready():
	pass

func _on_body_entered(body):
	if body.name == "Player":
		print("Game Has Ended")
		anim.play("end_game")
		Global.keep_time = false
		Global.save()
		
func return_to_main_menu():
	Global.load_main_menu()
