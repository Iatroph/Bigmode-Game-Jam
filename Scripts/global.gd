extends Node

var chairs = []

var main_menu_scene : PackedScene = preload("res://Scenes/main_menu.tscn")

func load_main_menu():
	get_tree().change_scene_to_packed(main_menu_scene)

func destroy_all_chairs():
	for i in chairs:
		if is_instance_valid(i):
			i.destroy_self()
	chairs.clear()


