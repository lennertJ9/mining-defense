extends Node2D

@onready var copper: MultiMeshInstance2D = $copper


func _process(delta: float) -> void:
	render_items()

func render_items():
	copper.multimesh.instance_count = count_draw()
	var item_instance = 0
	for belt: ConveyorBelt in ConveyorBeltManager.belt_grid.values():
		var i = 0
		for item in belt.slots:
			if item:
				var item_pos_x: float = belt.global_position.x - 8 + (i + 1) * 5.33 - belt.item_offsets[i]
				var item_pos_y: float = belt.global_position.y
				var item_pos: Vector2 = Vector2(item_pos_x, item_pos_y)
				draw_item(item_pos, item_instance)
				
				item_instance += 1
			i += 1

func draw_item(item_position: Vector2, index: int):
	var transform_2d = Transform2D(0, item_position)
	copper.multimesh.set_instance_transform_2d(index, transform_2d)


func count_draw():
	var instance_count = 0
	for belt in ConveyorBeltManager.belt_array:
		for item in belt.slots:
			if item:
				instance_count += 1
	return instance_count
