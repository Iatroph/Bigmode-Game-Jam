extends Node2D

@export var play_scene : PackedScene
@export var credits_panel : Panel

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(play_scene)


func _on_credits_button_pressed():
	credits_panel.visible = !credits_panel.visible
