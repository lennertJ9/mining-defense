extends Node2D


@onready var preview: Sprite2D = $Preview

var is_building
var current_building: Node2D


func _ready() -> void:
	set_process(false)
	await get_tree().physics_frame
	UserInterface.building_menu.pressed.connect(on_slot_pressed)
	

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	preview.global_position = Vector2(floor(mouse_pos.x / 16.0) * 16 +8, floor(mouse_pos.y / 16.0) * 16 +8)
	


func on_slot_pressed(building):
	is_building = true
	current_building = building
	set_process(true)
	building_preview(building.texture)


func building_preview(texture: Texture2D):
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	preview.texture = texture
	preview.name = "preview"
	add_child(preview)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and is_building:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		current_building.global_position = preview.global_position
		add_child(current_building)
		preview.texture = null
		is_building = false
		set_process(false)
		
	if event.is_action_pressed("mouse_scroll_up") and is_building:
		preview.rotate(-PI/2)
		current_building.rotate(-PI/2)
	if event.is_action_pressed("mouse_scroll_down") and is_building:
		preview.rotate(PI/2)
		current_building.rotate(PI/2)
		
