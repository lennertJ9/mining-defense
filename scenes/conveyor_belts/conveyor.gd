extends Node2D
class_name ConveyorBelt

@onready var label: Label = $Control/Label
@export var slots: Array[ConveyorItem] = []
var item_offsets: Array[float] = [0.0, 0.0, 0.0]
var grid_size: float = 5.3
var belt_speed: float = 20.0
const COPPER = preload("res://resources/conveyor_items/copper.tres")


var direction = Vector2.LEFT


func _ready() -> void:
	ConveyorBeltManager.register_belt(self)
	slots.resize(3)
	#ItemRenderer.draw(self)



func _process(delta: float) -> void:
	var i = 0
	for item in slots:
		if item:
			item_offsets[i] += delta * belt_speed
			item_offsets[i] = min(item_offsets[i], grid_size)
			if item_offsets[i] >= grid_size:
				
				if i == 0:
					var own_position = floor(global_position / 16)
					var should_be_next_conveyor = Vector2(own_position.x - 1, own_position.y)
					if ConveyorBeltManager.belt_grid.has(should_be_next_conveyor):
						var belt:ConveyorBelt = ConveyorBeltManager.belt_grid[should_be_next_conveyor]
						
						if belt.can_add_item():
							belt.add_item(slots[0])
							slots[0] = null
							item_offsets[0] = 0
				else:
					if slots[i-1] == null:
						slots[i - 1] = slots[i]
						slots[i] = null
						
						item_offsets[i] = 0
		i += 1



func show_holding_items() -> String:
	var i = 0
	var ID: int
	var texture: Texture
	for item in slots:
		if item:
			i += 1
	return str(i)


func can_add_item() -> bool:
	if slots[2] == null:
		return true
	else:
		return false


func add_item(item: ConveyorItem):
	slots[2] = item
	


func _on_control_mouse_entered() -> void:
	label.visible = true
	label.text = show_holding_items()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		slots[2] = COPPER
		#slots[0] = COPPER
		
		print('add')


func _on_control_mouse_exited() -> void:
		label.visible = false
