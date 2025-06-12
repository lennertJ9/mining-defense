extends TextureRect

signal pressed

@export var building: PackedScene




func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			pressed.emit(building.instantiate())
