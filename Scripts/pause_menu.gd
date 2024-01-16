extends CanvasLayer

@onready var pause_bar : TextureProgressBar = $Control/TextureProgressBar
@onready var time_label : Label = $Control/Time

var step = 1

func _process(delta):
	if Input.is_action_pressed("Escape"):
		pause_bar.value = pause_bar.value + step
	else:
		pause_bar.value = pause_bar.value - step
		
	if pause_bar.value == pause_bar.max_value:
		Global.load_main_menu()
	time_label.text = Global.formattedTime
