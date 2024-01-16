extends Node2D

@export var play_scene : PackedScene
@export var credits_panel : Panel
@export var time_label : Label

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Global.load_data()
	time_label.text = "Best Time\n" + str(Global.convert_time(Global.best_time))

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(play_scene)

func _on_credits_button_pressed():
	credits_panel.visible = !credits_panel.visible
