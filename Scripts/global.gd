extends Node

var chairs = []

var time = 0
var formattedTime
var keep_time : bool = true

var main_menu_scene : PackedScene = preload("res://Scenes/main_menu.tscn")
var play_scene : PackedScene = preload("res://Scenes/world.tscn")

var best_time = 0

var save_path = "user://variable.save"

func _process(delta):
	if keep_time == true:
		time += delta
		var mils = fmod(time,1) * 100
		var secs = fmod(time, 60)
		var mins = fmod(time,60*60) / 60
		formattedTime = "%02d : %02d : %02d" % [mins, secs, mils]

func convert_time(time_to_convert):
	var mils = fmod(time_to_convert,1) * 100
	var secs = fmod(time_to_convert, 60)
	var mins = fmod(time_to_convert,60*60) / 60
	var new_time = "%02d : %02d : %02d" % [mins, secs, mils]
	return new_time
	

func load_main_menu():
	get_tree().change_scene_to_packed(main_menu_scene)

func destroy_all_chairs():
	for i in chairs:
		if is_instance_valid(i):
			i.destroy_self()
	chairs.clear()

func reset_time():
	time = 0
	keep_time = true

func save():
	if time > best_time:
		best_time = time
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(best_time)
	
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		best_time = file.get_var(best_time)
		print(best_time)
	else:
		print("No data in file")
		best_time = 0
