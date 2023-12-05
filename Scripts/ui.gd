extends Control

@onready var crosshair = $"Sprite2D"

func _process(delta):
	crosshair.position = get_global_mouse_position()
