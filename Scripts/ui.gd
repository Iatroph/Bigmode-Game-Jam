extends Control

@onready var crosshair = $"Sprite2D"
@onready var charge_meter = $Sprite2D/Control/TextureProgressBar

@onready var player : Object = get_node("../Player")

@export var stars : Array[Sprite2D]

@export var red : Color
@export var white : Color


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	crosshair.position = get_global_mouse_position()
	charge_meter.value = player.throw_strength
	update_chair_ui()

func update_chair_ui():
	match Global.chairs.size():
		4:
			stars[0].modulate = white
			stars[1].modulate = white
			stars[2].modulate = white
			stars[3].modulate = white
		3:
			stars[0].modulate = red
			stars[1].modulate = white
			stars[2].modulate = white
			stars[3].modulate = white
		2:
			stars[0].modulate = red
			stars[1].modulate = red
			stars[2].modulate = white
			stars[3].modulate = white
		1:
			stars[0].modulate = red
			stars[1].modulate = red
			stars[2].modulate = red
			stars[3].modulate = white
		0:
			stars[0].modulate = red
			stars[1].modulate = red
			stars[2].modulate = red
			stars[3].modulate = red
		_:
			stars[0].modulate = red
			stars[1].modulate = red
			stars[2].modulate = red
			stars[3].modulate = red
