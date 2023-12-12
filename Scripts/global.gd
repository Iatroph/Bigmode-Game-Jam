extends Node

var chairs = []

func destroy_all_chairs():
	for i in chairs:
		if is_instance_valid(i):
			i.queue_free()
	chairs.clear()
