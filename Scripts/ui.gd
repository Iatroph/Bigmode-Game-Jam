extends Control

@onready var crosshair = $"Sprite2D"
@onready var charge_meter = $Sprite2D/Control/TextureProgressBar

@onready var player : Object = get_node("../Player")

func _process(delta):
	crosshair.position = get_global_mouse_position()
	charge_meter.value = player.throw_strength
