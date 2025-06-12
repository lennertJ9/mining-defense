extends Control

signal pressed

@onready var grid_container: GridContainer = $TextureRect/GridContainer
@onready var item_preview: TextureRect = $ItemPreview


func _ready() -> void:
	set_process(false)
	for slot in grid_container.get_children():
		slot.pressed.connect(on_slot_pressed)




func on_slot_pressed(building):
	pressed.emit(building)
