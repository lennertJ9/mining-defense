extends Node2D


var belt_grid: Dictionary[Vector2,ConveyorBelt] = {}
var belt_array: Array[ConveyorBelt]



func register_belt(belt: Node2D):
	var grid_pos: Vector2 = Vector2(belt.global_position / 16).floor()
	belt_grid[grid_pos] = belt



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		print(belt_grid)
