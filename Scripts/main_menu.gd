extends Node2D

@export var play_scene : PackedScene
@export var credits_panel : Panel

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(play_scene)

func _on_credits_button_pressed():
	credits_panel.visible = !credits_panel.visible
